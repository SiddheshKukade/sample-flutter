import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample1/view/login_view.dart';
import 'package:sample1/view/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // to load firebase before anything else loads on the screen.
  //  WidgetFlutterBinding is used to interact with the Flutter engine. Firebase.initializeApp() needs to call native code to initialize Firebase, and since the plugin needs to use platform channels to call the native code, which is done asynchronously therefore you have to call ensureInitialized() to make sure that you have an instance of the WidgetsBinding.
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.brown,
    ),
    home: const HomePage(),
  ));
}

//homepage does the initialization and depending on the user it loads the login or register data
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My good home page'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          // snapshot is the result of the above future once it is resolved€
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;

              if (user?.emailVerified ?? false) {
                print("your email is verified");
              } else {
                print("not verified");
              }
              return const Text("Loaded firebase in home page ");
            default:
              return const Text("Loadig my suir ");
          }
        },
      ),
    );
  }
}
