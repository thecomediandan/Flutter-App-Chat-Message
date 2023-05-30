import 'package:flutter/material.dart';
import 'package:flutter_app_yes_no_app/config/helpers/get_yes_no_answer.dart';

import '../../domain/entities/message.dart';

// * Utilizar la librería provider solo es necesario una clase que extienda de ChangeNotifier
class ChatProvider extends ChangeNotifier {
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();
  final ScrollController scrollController = ScrollController();

  List<Message> messageList = [
    Message(text: 'Hola :v', fromWho: FromWho.mine),
    Message(text: ':v', fromWho: FromWho.mine),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) {
      return;
    }

    if (text.endsWith('?')) {
      herReply();
    }

    // * El mensaje siempre será nuestro en este ejemplo
    messageList.add(Message(text: text, fromWho: FromWho.mine));
    // * Requerimos de notifyListeners() para notificar cambios con clases que extienden de ChangeNotifier
    notifyListeners();
    scrollUp();
  }

  // * Volvemos el metodo scrollUp en Asincrono que devuelve un Future vacio, porque necesitamos que primero obtenga un valor, en este caso un Delayed para que de tiempo a procesar el mensaje enviado, para luego mostrar la animacion del Scroll
  Future<void> scrollUp() async {
    await Future.delayed(const Duration(milliseconds: 100));
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();
    scrollUp();
  }
}
