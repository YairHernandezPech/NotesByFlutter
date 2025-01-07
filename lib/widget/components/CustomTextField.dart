import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final TextStyle? varianText;
  final TextEditingController? controller; // Añadir el controlador

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.varianText,
    this.controller, // Aceptar el controlador
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Utilizar el controlador
      obscureText: obscureText, // Permite ocultar el texto si se desea
      cursorColor: Colors.black87, // Color del cursor
      maxLines: maxLines,
      minLines: minLines,
      style: varianText,
      decoration: InputDecoration(
        hintText: 'Ingrese su texto aquí',
        filled: true,
        fillColor: const Color.fromARGB(130, 255, 255, 255),
        labelText: labelText, // Texto de la etiqueta
        labelStyle: const TextStyle(color: Colors.black87),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black87), // Color del borde cuando no está enfocado
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black87), // Color del borde cuando está enfocado
        ),
      ),
    );
  }
}
