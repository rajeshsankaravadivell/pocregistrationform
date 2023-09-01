import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile(
      {super.key,
      required this.name,
      required this.nricFin,
      required this.companyName,
      required this.designation,
      required this.phone,
      required this.person,
      required this.place,
      required this.purpose,
      required this.inTime});

  final String name;
  final String nricFin;
  final String companyName;
  final String designation;
  final String phone;
  final String person;
  final String place;
  final String purpose;
  final String inTime;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(child: Image.asset("logo.jpeg")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(child: Image.asset("thumps.png")),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 20,bottom: 20
              ),
              child: Text('Powered by ',style: TextStyle(color: Colors.green),),
            ),
            Image.network(
              'https://www.digisailor.com/assets/img/digisailorlogo.png',
              height: 100,
              width: 100,
            ),
          ]),
    );
  }
}
