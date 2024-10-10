import 'package:cpor_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cpor_chat/screens/welcome_screen.dart';
import 'package:cpor_chat/screens/login_screen.dart';
import 'package:cpor_chat/screens/registration_screen.dart';
import 'package:cpor_chat/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const CporChat());
}

class CporChat extends StatelessWidget {
  const CporChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) {return WelcomeScreen();},
        LoginScreen.id: (context){ return LoginScreen();},
        RegistrationScreen.id: (context){ return RegistrationScreen();},
        ChatScreen.id: (context){ return ChatScreen();},
      },
    );
  }
}
