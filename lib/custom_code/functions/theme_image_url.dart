import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';

String themeImageUrl(String theme) {
  const String base =
      'assets/images';

  const String iconoSecundaria =
      '$base/Secundaria-removebg-preview.png';
  const String iconoHistoria = '$base/pp1jx13flwpr.png';

  final Map<String, String> imagenes = {
    'FUTBOL': '$base/Futbol.png',
    'MUNDIALES': '$base/mundiales.png',
    'REGUETON': '$base/Regueton.png',
    'MADRIDISTA': '$base/realmadrid.png',
    'BARCELONISTA': '$base/barcelona.png',
    'Cuerpo humano': '$base/Esqueleto-removebg-preview.png',
    'INVENTORES': '$base/Inventores-removebg-preview.png',
    'HISTORIA DE ESPAÑA': iconoHistoria,
    'ESO Matemáticas': iconoSecundaria,
    'ESO Lengua': iconoSecundaria,
    'ESO Geografía e Historia': iconoHistoria,
    'ESO Física y Química': iconoSecundaria,
    'ESO Biología y Geología': iconoSecundaria,
  };

  return imagenes[theme.trim()] ?? iconoSecundaria;
}
