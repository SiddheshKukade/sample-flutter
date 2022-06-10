import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    // _email = TextEditingController();
    // _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("Login ID OP ")),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          // snapshot is the result of the above future once it is resolved€
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(
                        hintText: "Login Email de re pahile"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _password,
                    decoration:
                        const InputDecoration(hintText: "Password de re "),
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                  TextButton(
                      onPressed: () async {
                        try {
                          final email = _email.text;
                          final password = _password.text;
                          final userCredentail = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);

                          print(userCredentail);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "user-not-found") {
                            print("user is not founs here");
                          } else if (e.code == "wrong-password") {
                            print("Error Ocured  bro pass is worng ");
                          } else {
                            print("Something else is hapend ned");
                          }
                        }
                      },
                      child: const Text("Login Man ")),
                ],
              );
            default:
              return const Text("Loadig my suir ");
          }
        },
      ),
    );
  }
}

//to connect to firebase we need the firebase_option
