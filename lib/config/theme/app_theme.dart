import 'package:flutter/material.dart';

// * Ejemplo de un color personalizado
const Color _customColor = Color(0xFF8E0DE4);

// * Lista de colores para poder seleccionarlos
const List<Color> _colorThemes = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

// * Esta clase se encarga de establecer los temas de la aplicacion
class AppTheme {
  // * Hace referencia al color seleccionado con el indice de la lista _colorThemes
  final int selectedColor;

  // * El constructor por defecto recibira un entero, que significara el indice de la lista _colorThemes
  // * Utilizamos Asserts para controlar entrada de datos validos par la aplicacion con errores controlados
  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            'selecetedColor debe estar entre los valores 0 y ${_colorThemes.length}'); // ? o required this.electedColor
  // * Retornamos un ThemeData que sirve para establecer un tema al respecto
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
      // ? brightness: Brightness.dark // Esto habilita el modo oscuro
    );
  }
}
