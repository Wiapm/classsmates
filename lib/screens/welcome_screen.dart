import 'package:flutter/material.dart';
import 'package:project_flutter/screens/registration_screen.dart';
import 'package:project_flutter/screens/signin_screen.dart';

import '../widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 252, 195),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Container(height: 250, child: Image.asset('images/ff.png')),
                  ],
                ),
                SizedBox(height: 30),
                MyButton(
                  color: Color.fromARGB(255, 33, 51, 243),
                  title: 'Se connecter',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RegistrationScreen.screenRoute);
                  },
                ),
                MyButton(
                  color: Color.fromARGB(255, 198, 42, 53),
                  title: 'S`inscrire',
                  onPressed: () {
                    Navigator.pushNamed(context, SignInScreen.screenRoute);
                  },
                )
              ]),
        ));
  }
}
