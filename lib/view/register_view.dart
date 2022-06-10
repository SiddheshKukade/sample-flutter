import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(title: new Text("Sample ID OP ")),
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
                    decoration:
                    const InputDecoration(hintText: "Email de re pahile"),
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
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          print(userCredentail);
                        } on FirebaseAuthException catch (e) {
                          if(e.code == 'weak-password'){
                            print("password is too weak mean");
                          }else if(e.code == 'invalid-email'){
                            print("Your Email is invaluid");
                          }
                          print(e.code);
                        } catch (e) {
                          print("DIfferent Erro has occured");
                        }
                      },
                      child: const Text("Register Man ")),
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
