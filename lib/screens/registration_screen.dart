// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'categories_screen.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>(); // Ajout d'une clé de formulaire

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 252, 195),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 180, child: Image.asset('images/ff.png')),
            SizedBox(height: 50),
            Form(
              key: _formKey, // Assigner la clé de formulaire au formulaire
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!isEmailValid(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Entrer votre Email',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 86, 99, 244), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 33, 51, 243), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Entrer votre Mot de passe',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 86, 99, 244), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 33, 51, 243), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  MyButton(
                    color: Color.fromARGB(255, 33, 51, 243),
                    title: 'Se connecter',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Vérifier si le formulaire est valide
                        try {
                          final User = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (User != null) {
                            Navigator.pushNamed(
                                context, CategoriesScreen.screenRoute);
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    // Vérifier si l'email a un format valide en utilisant une expression régulière
    // Ici, nous utilisons une expression régulière simple pour la démonstration
    // Vous pouvez utiliser une expression régulière plus complexe pour une vérification plus précise
    final emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(emailRegex).hasMatch(email);
  }
}
