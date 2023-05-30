import 'package:flutter/material.dart';
import 'package:flutter_app_yes_no_app/domain/entities/message.dart';

//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
// * Mensajes de parte mia
class MyMessageBuble extends StatelessWidget {
  final Message msg;
  const MyMessageBuble({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    // * Theme.of(context).colorScheme con esto obtenemos los colores del contexto (de la App)
    final colors = Theme.of(context).colorScheme;

    return Column(
      // * Alineamos los chat de parte mia a la izquierda
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // * Parecido a un DIV en HTML
        Container(
          // * Decoraciones del contenedor
          decoration: BoxDecoration(
              color: colors.primary, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              msg.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        // * Widget de separación de elementos
        const SizedBox(
          height: 10,
        ),
        // // * Imagen que aparecera como envio de parte mia
        // _ImageMessageBubble(),
        // // * Widget de separación de elementos
        // const SizedBox(
        //   height: 10,
        // )
      ],
    );
  }
}

// * Este es el Widget con estado que contendrá las imagenes de envio
// * API de Gifs https://yesno.wtf/api utilizar Postman
class _ImageMessageBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // * Con esto obtenemos las dimensiones del dispositivo
    final size = MediaQuery.of(context).size;
    // * Con ClipRRect podemos envolver una imagen al cual tratar algunas propiedades
    return ClipRRect(
      // * Bordeamos las esquinas de la imagen
      borderRadius: BorderRadius.circular(20),
      // * Como hijo del Widget ponemos un Image
      child: Image(
          // * Con loadingBuilder controlamos la carga de la imagen, context: Contexto del ambito, child: Elemento de referencia (la propia imagen), loadingProgress: Evento de la carga de la imagen, carga en tiempo deconstruccion.
          loadingBuilder: (context, child, loadingProgress) {
            // * Si La carga termina, enviamos la imagen
            if (loadingProgress == null) return child;
            // * Si la imagen aun esta siendo cargada, mostramos un Widget en su lugar
            return Container(
              // * Tomamos el 70% del ancho total del dispositivo
              width: size.width * 0.7,
              height: 150,
              // * Padding interno
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text('Te estoy enviando una imagen.'),
            );
          },
          // * Ajuste de la imagen en la caja o contenedor
          fit: BoxFit.cover,
          width: size.width * 0.7,
          // * Capturamos la imagen de internet
          image: const NetworkImage(
              'https://yesno.wtf/assets/no/21-05540164de4e3229609f106e468fa8e7.gif')),
    );
  }
}
