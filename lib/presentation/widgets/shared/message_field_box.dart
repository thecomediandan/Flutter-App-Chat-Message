import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  // * Requerimos de ValueChanged, un tipo de variable que almacena una funcion que no retorna nada, en el cual especificamos que espera recibir un String como parámetro con <String>
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    // * Con TextEditingController podemos encontrar información del input
    final textController = TextEditingController();
    // * Creamos un objeto de foco, y se lo agregamos al input para controlar el foco
    final focusNode = FocusNode();
    // final colors = Theme.of(context).colorScheme;
    final outlineInputBorder = UnderlineInputBorder(
        // * Damos transparencia al borde para darle el efecto deseado
        borderSide: const BorderSide(color: Colors.transparent),
        // * Borde del input
        borderRadius: BorderRadius.circular(40));

    final inputDecoration = InputDecoration(
        hintText: 'Termina tu mensaje con un "?"',
        // * aplica las configuraciones de outlineInputBorder en el borde del input
        enabledBorder: outlineInputBorder,
        // * aplica las configuraciones de outlineInputBorder cuando se le hace foco al input
        focusedBorder: outlineInputBorder,
        // * Aplica color del tema en el fondo del input
        filled: true,
        // * Aqui va el boton de envío, el submit
        suffixIcon: IconButton(
            onPressed: () {
              // print('El mensaje es: ${textController.value.text}');
              // * onFieldSubmitted recibe como elemento una funcion vacía de tipo ValueChanged, que a diferencia de VoidCallback en el onEditingComplete o cualquier otra funbcion sin parámetros, este recibe parámetros. Usamos esta lógica para crear una variable que almacene una funcion que reciba paramteros para funcionar a la cual lllamamos onValue
              onValue(textController.value.text);
              textController.clear();
              focusNode.requestFocus();
            },
            icon: const Icon(Icons.send_outlined)));

    return TextFormField(
      // * Para manejar el tema del focus del input
      focusNode: focusNode,
      // * Controlador del texto de entrada del input
      controller: textController,
      // * Decoraciones que se le aplica al TextFormField
      decoration: inputDecoration,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      // * Este evento captura cada vez que se envia la información a traves del boton de envio que tiene por defecto el TextFormField (suffixIcon del inputDecoration)
      onFieldSubmitted: (value) {
        // print('Submit value: $value');
        // * onFieldSubmitted recibe como elemento una funcion vacía de tipo ValueChanged, que a diferencia de VoidCallback en el onEditingComplete o cualquier otra funbcion sin parámetros, este recibe parámetros. Usamos esta lógica para crear una variable que almacene una funcion que reciba paramteros para funcionar a la cual lllamamos onValue
        onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
      // * Este evento captura el valor del input cada vez que cambia
      onChanged: (value) {
        print('changed: $value');
      },
    );
  }
}
