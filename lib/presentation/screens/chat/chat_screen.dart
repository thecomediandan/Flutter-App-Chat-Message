import 'package:flutter/material.dart';
import 'package:flutter_app_yes_no_app/domain/entities/message.dart';
import 'package:flutter_app_yes_no_app/presentation/providers/chat_provider.dart';
import 'package:flutter_app_yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:flutter_app_yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:flutter_app_yes_no_app/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // * Modelo de la App del tipo Scaffold
    return Scaffold(
      appBar: AppBar(
        // * Configuracion de la imgen de usuario en el AppBar
        leading: const Padding(
          // * Padding en todos los sentidos
          padding: EdgeInsets.all(3.0),
          // * Contenedor circular para la imagen
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://openpsychometrics.org/tests/characters/test-resources/pics/SLP/2.jpg'),
          ),
        ),
        title: const Text('Mi Amor'),
        // * Para centrar el titulo o no
        centerTitle: false,
      ),
      // * En el body enviamos el Widget del chat en general
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    // * SafeArea es un Widget que puede detectar los botones del móvil que puedan interferir con la visibilidad del Widget
    return SafeArea(
      child: Padding(
        // * Configuramos un espaciado a los lados del chat
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // * Con Expanded ocupamos la totalidad del espacio disponible, se le introduce un child
            Expanded(
                // * Introducimos una lista de items
                child: ListView.builder(
              // * Todo Widget que contenga un Scroll tiene un Controller el cual vinculamos con el provider
              controller: chatProvider.scrollController,
              // * Cantidad de items
              itemCount: chatProvider.messageList.length,
              // * Comportamiento de los items en tiempo de construccion, recibe contexto y el indice del item.
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];

                // * Como no es nada aplicable la aplicacion aun, llenamos el chat de esta forma: (Mis mensajes y los mensajes de ella)
                return message.fromWho != FromWho.hers
                    ? MyMessageBuble(
                        msg: message,
                      )
                    : HerMessageBubble(
                        msg: message,
                      );
              },
            )),
            // * Input del chat
            MessageFieldBox(
              // * Necesitamos capturar el mensaje enviado, y como este es un valor esperado a futuro, usamos nuestro método de nuestro provider 'Future<void> sendMessage(String text) async' que devuelve un future<void> un valor esperado a futuro, el cual luego de realizar el cambio actualiza el estado. Para esto enviamos una funcion anónima a traves de MessageFieldBox, porque ahi se encuentran los métodos de envio de informacion

              // ?  forma corta válida: onValue: chatProvider.sendMessage,
              onValue: (value) => chatProvider.sendMessage(value),
            )
          ],
        ),
      ),
    );
  }
}
