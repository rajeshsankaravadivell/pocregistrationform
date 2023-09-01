import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                    child: SizedBox(
                        width: 200,
                        height: 80,
                        child: Image.asset("assets/logo.jpeg"))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                    child: SizedBox(
                        width: 300,
                        height: 150,
                        child: Image.asset("thumps.png"))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      "Name : ${widget.name} / ${widget.designation}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "NRIC / FIN : ${widget.nricFin}",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Organisation : ${widget.companyName}",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "DATE : ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(widget.inTime))}",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "You may enter the JCET facilities now",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 450,
                      child: Text(
                        "This pass is provided to visit Mr.${widget.person} in the department of ${widget.place} for the purpose of ${widget.purpose}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      width: 400,
                      child: Text(
                        "Please take a screenshot of this page and present it to security when you leave onsite",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 5, bottom: 10),
              //   child: Text(
              //     'Powered by ',
              //     style: TextStyle(color: Colors.green),
              //   ),
              // ),
              // Image.asset(
              //   "assets/logo.jpeg",
              //   height: 50,
              //   width: 100,
              // ),
              const SizedBox(
                height: 20,
              )
            ]),
      ),
    );
  }
}
