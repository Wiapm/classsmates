import 'package:flutter/material.dart';
import 'package:project_flutter/screens/categories_screen.dart';
import 'package:project_flutter/screens/vote_screen.dart';
import './screens/category_etu_screens.dart';
import 'package:project_flutter/screens/chat_screen.dart';
import 'package:project_flutter/screens/registration_screen.dart';
import 'package:project_flutter/screens/signin_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBPdCAUTobRNptKKeCXZbCV0YOoMl_9FRA',
          appId: '1:750896141174:android:04ee2570479a83e5baa057',
          messagingSenderId: '750896141174',
          projectId: 'projet-de-cooperative'),
    );
    runApp(MyApp());
    // Your code that may throw an error or exception
  } catch (e) {
    print('Error: $e');
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        // delegate from flutter_localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // delegate from localization package.
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 157, 132, 198)),
        useMaterial3: true,
      ),
      // home: ChatScreen(),
      initialRoute: _auth.currentUser != null
          ? CategoriesScreen.screenRoute
          : WelcomeScreen.screenRoute,
      routes: {
        CategoryEtuScreen.screenRouter: (ctx) => const CategoryEtuScreen(),
        WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
        SignInScreen.screenRoute: (context) => const SignInScreen(),
        RegistrationScreen.screenRoute: (context) => const RegistrationScreen(),
        CategoriesScreen.screenRoute: (context) => const CategoriesScreen(),
        ChatScreen.screenRoute: (context) => const ChatScreen(),
        VoteScreen.screenRoute: (context) => VoteScreen(),
      },
    );
  }
}
