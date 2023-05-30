import 'package:flutter/material.dart';
import 'package:flutter_app_yes_no_app/config/theme/app_theme.dart';
import 'package:flutter_app_yes_no_app/presentation/providers/chat_provider.dart';
import 'package:flutter_app_yes_no_app/presentation/screens/chat/chat_screen.dart';
import 'package:provider/provider.dart';

// * Creación rápida de la applicacion escribiendo mateapp
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // * Al instalar la librería de provider, podemos englobar el widget que queremos que vatan escuchando los cambios, esto afectará a los hijos de este Widget más no a los de un nivel superior
    return MultiProvider(
      // * Podemos introducir varios providers para diferentes acciones
      providers: [
        // ? En el create ponemos _ para identificar que context no será utilizado
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yes No App',
        // * Accedemos al Widget de control de Temas e introducicmos un numero que hace referencia al arreglo de temas que tenemos preconfigurados
        theme: AppTheme(selectedColor: 6).theme(),
        home: const ChatScreen(),
      ),
    );
  }
}
