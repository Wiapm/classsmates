// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_flutter/screens/categories_screen.dart';
import 'package:project_flutter/screens/chat_screen.dart';

import '../widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute = 'signin_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String name;
  late String num;
  late String coop;
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
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_pin_circle),
                      hintText: 'Entrer votre Nom complet',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 56, 67),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 198, 42, 53),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Entrer votre Email',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 56, 67),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 198, 42, 53),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Entrer votre  Mot de passe ',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 56, 67),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 198, 42, 53),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    num = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Entrer votre numéro de telephone',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 56, 67),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 198, 42, 53),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    coop = value;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.add_business),
                      hintText: 'Entrer votre adresse ',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 56, 67),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 198, 42, 53),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                MyButton(
                  color: Color.fromARGB(255, 211, 56, 67),
                  title: 'S\'inscrire',
                  onPressed: () async {
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Save the data in Firestore
                      // Save the data in Firestore
                      await FirebaseFirestore.instance
                          .collection('utilisateurs')
                          .doc(newUser.user!.uid)
                          .set({
                        'id_utilisateur': newUser
                            .user!.uid, // Ajoutez le nouvel ID utilisateur
                        'nom_complet': name,
                        'coopérative': coop,
                        'numéro': num,
                        'email': email,
                        'password': password,
                      });

                      Navigator.pushNamed(
                          context, CategoriesScreen.screenRoute);
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ]),
        ));
  }
}
