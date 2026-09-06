// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> unirseAPartida(
  String codigo,
  String nombre,
) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('Error: No hay usuario autenticado');
      return '';
    }

    final db = FirebaseFirestore.instance;

    final querySnapshot = await db
        .collection('partidas')
        .where('codigo', isEqualTo: codigo)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      debugPrint('Error: Partida no encontrada con código: $codigo');
      return '';
    }

    final docRef = querySnapshot.docs.first.reference;
    final partidaData = querySnapshot.docs.first.data();

    if (partidaData['estado'] != 'lobby') {
      debugPrint('Error: La partida no está en lobby');
      return '';
    }

    final jugadoresSnapshot = await docRef.collection('jugadores').get();
    if (jugadoresSnapshot.docs.length >= (partidaData['maxJugadores'] ?? 8)) {
      debugPrint('Error: Máximo de jugadores alcanzado');
      return '';
    }

    await docRef.collection('jugadores').doc(user.uid).set({
      'nombre': nombre,
      'puntos': 0,
      'esAnfitrion': false,
      'respuestaIndice': -1,
      'respuestaEnPregunta': -1,
      'respondidoEn': null,
      'activo': true,
      'salidaEn': null,
      'ultimoLatido': DateTime.now(),
    });

    debugPrint('Jugador ${user.uid} se unió a partida: ${docRef.id}');
    return docRef.id;
  } catch (e) {
    debugPrint('Error al unirse a partida: $e');
    return '';
  }
}
