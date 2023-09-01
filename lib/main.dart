import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pocregistrationform/registrationpage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'JCET',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: EasySplashScreen(
          logo: Image.asset("assets/logo.jpeg"),
          title: const Text(
            "Welcome",
            style: TextStyle(
              fontSize: 30,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          showLoader: true,
          loadingText: const Text("Loading..."),
          // navigator:  Profile(
          //   name: 'Felix',
          //   nricFin: '12345678',
          //   companyName: 'Digisailor',
          //   designation: 'Sr. Developer',
          //   phone: '9677998011',
          //   person: 'Rajesh',
          //   place: 'Head Quaters',
          //   purpose: 'Interview',
          //   inTime: '31 - 08 - 2023 10:00AM',
          // ),
          navigator: const RegistrationPage(),
          durationInSeconds: 2,
        ));
  }
}
