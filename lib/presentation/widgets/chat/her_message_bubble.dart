import 'package:flutter/material.dart';

//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
// * Mensajes de parte de ella
class HerMessageBubble extends StatelessWidget {
  const HerMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    // * Theme.of(context).colorScheme con esto obtenemos los colores del contexto (de la App)
    final colors = Theme.of(context).colorScheme;

    return Column(
      // * Alineamos los chat de parte ella a la derecha
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // * Parecido a un DIV en HTML
        Container(
          // * Decoraciones del contenedor
          decoration: BoxDecoration(
              color: colors.secondary, borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'lorem jfnsuoidhnfio',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // * Widget de separación de elementos
        const SizedBox(
          height: 10,
        ),
        // * Imagen que aparecera como envio de parte de ella
        _ImageMessageBubble(),
        // * Widget de separación de elementos
        const SizedBox(
          height: 10,
        ),
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
              'https://yesno.wtf/assets/yes/11-a23cbde4ae018bbda812d2d8b2b8fc6c.gif')),
    );
  }
}
