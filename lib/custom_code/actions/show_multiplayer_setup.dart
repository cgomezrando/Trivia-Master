// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future showMultiplayerSetup(BuildContext context) async {
  final temas = FFAppState().selectedThemes.toList();
  if (temas.isEmpty) {
    _avisoSetup(context, 'Elige al menos una categoría para jugar.');
    return;
  }

  String nombre = '';
  String modo = 'crear';
  String codigoUnirse = '';
  bool procesando = false;
  String? error;

  const cardBg = Color(0xFF050C18);
  const gold = Color(0xFFFFD54F);
  const borderInactivo = Color(0xFF182544);

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: cardBg,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: gold, width: 2),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'MULTIJUGADOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: gold,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    const SizedBox(height: 20),
                    if (error != null) ...[
                      Text(error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.redAccent)),
                      const SizedBox(height: 12),
                    ],
                    TextField(
                      enabled: !procesando,
                      onChanged: (v) => nombre = v,
                      style: const TextStyle(color: Colors.white),
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'Tu nombre',
                        labelStyle: const TextStyle(color: Colors.white70),
                        counterStyle: const TextStyle(color: Colors.white38),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: borderInactivo, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: gold, width: 2)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: procesando
                                ? null
                                : () => setState(() {
                                      modo = 'crear';
                                      error = null;
                                    }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10233D),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color:
                                        modo == 'crear' ? gold : borderInactivo,
                                    width: modo == 'crear' ? 3 : 2),
                              ),
                              child: const Text('Crear Sala',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: procesando
                                ? null
                                : () => setState(() {
                                      modo = 'unirse';
                                      error = null;
                                    }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10233D),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: modo == 'unirse'
                                        ? gold
                                        : borderInactivo,
                                    width: modo == 'unirse' ? 3 : 2),
                              ),
                              child: const Text('Unirse a Sala',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (modo == 'unirse') ...[
                      const SizedBox(height: 20),
                      TextField(
                        enabled: !procesando,
                        onChanged: (v) => codigoUnirse = v,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 6),
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Código de 4 dígitos',
                          labelStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: borderInactivo, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: gold, width: 2)),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed:
                                procesando ? null : () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: borderInactivo, width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('Cancelar',
                                style: TextStyle(color: Colors.white70)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: procesando
                                ? null
                                : () async {
                                    if (nombre.trim().isEmpty) {
                                      setState(
                                          () => error = 'Escribe tu nombre.');
                                      return;
                                    }
                                    if (modo == 'unirse' &&
                                        codigoUnirse.trim().length != 4) {
                                      setState(() =>
                                          error = 'El código tiene 4 dígitos.');
                                      return;
                                    }
                                    setState(() {
                                      procesando = true;
                                      error = null;
                                    });

                                    String partidaId = '';
                                    try {
                                      if (modo == 'crear') {
                                        final cuantas =
                                            FFAppState().numberOfQuestions > 0
                                                ? FFAppState().numberOfQuestions
                                                : 10;
                                        partidaId = await crearPartida(
                                            temas,
                                            cuantas,
                                            true,
                                            20,
                                            8,
                                            nombre.trim());
                                      } else {
                                        partidaId = await unirseAPartida(
                                            codigoUnirse.trim(), nombre.trim());
                                      }
                                    } catch (_) {
                                      partidaId = '';
                                    }

                                    if (partidaId.isEmpty) {
                                      setState(() {
                                        procesando = false;
                                        error = modo == 'crear'
                                            ? 'No se ha podido crear la sala. Inténtalo de nuevo.'
                                            : 'No se ha encontrado esa sala. Comprueba el código.';
                                      });
                                      return;
                                    }

                                    FFAppState().update(() {
                                      FFAppState().partidaId = partidaId;
                                      FFAppState().isOnlineMode = true;
                                    });
                                    Navigator.pop(ctx);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: gold,
                              foregroundColor: cardBg,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: procesando
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: cardBg))
                                : Text(modo == 'crear' ? 'Crear' : 'Unirse',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );

  if (context.mounted &&
      FFAppState().isOnlineMode &&
      FFAppState().partidaId.isNotEmpty) {
    context.goNamed('GamePage');
  }
}

void _avisoSetup(BuildContext context, String mensaje) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensaje,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
      backgroundColor: const Color(0xFF10233D),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(24),
    ),
  );
}
