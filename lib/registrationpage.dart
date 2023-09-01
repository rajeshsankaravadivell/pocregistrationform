import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocregistrationform/profile.dart';
import 'package:pocregistrationform/qrview.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nricFin = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController persontovisit = TextEditingController();
  TextEditingController placeofvisit = TextEditingController();
  TextEditingController purposeofvisit = TextEditingController();
  TextEditingController emergencyPhoneController = TextEditingController();
  TextEditingController inTime = TextEditingController();

  @override
  void initState() {
    inTime.text = DateTime.now().toString();
    // TODO: implement initState
    super.initState();
  }

  // TextEditingController locationController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('Visitors');
  bool isChecked = false;
  bool termsConditons = false;
  bool approved = false;

  Future<void> addVisitor(dynamic myData) {
    // Call the user's CollectionReference to add a new user
    return users.doc(phoneController.text).set(myData).then((value) {
      if (isChecked == false || termsConditons == false || approved == false) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('You will not allowed to visit without Covid certificate '),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Please verify your QR code'),
            content: SizedBox(
              height: 300,
              width: 300,
              child: Card(
                child: Center(
                  child: QrImageView(
                    data: nameController.text,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }).catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save data')),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.green;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registration'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRviewpage()),
                );
              },
              icon: const Icon(Icons.document_scanner_outlined))
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image.network('https://www.digisailor.com/assets/img/digisailorlogo.png',h),
              CustomTextField(
                sufficicon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                hintext: 'Enter Your Name',
                label: 'Name',
                controller: nameController,
              ),
              CustomTextField(
                sufficicon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                hintext: 'Enter Your NRIC / FIN',
                label: 'NRIC / FIN',
                controller: nricFin,
              ),
              CustomTextField(
                sufficicon: const Icon(Icons.location_city_outlined),
                label: 'Organisation',
                hintext: 'Enter Your organisation',
                controller: companyNameController,
              ),
              CustomTextField(
                sufficicon: const Icon(Icons.location_city_outlined),
                label: 'Designation',
                hintext: 'Enter Your Designation',
                controller: designation,
              ),
              CustomTextField(
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                sufficicon: const Icon(Icons.phone),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your Phone number';
                  }
                  return null;
                },
                label: 'Phone',
                hintext: '+91 ',
                controller: phoneController,
              ),
              CustomTextField(
                sufficicon: const Icon(Icons.mail),
                label: 'Email',
                hintext: 'name@gmail.com',
                controller: emailController,
              ),
              CustomTextField(
                maxlength: 1,
                sufficicon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Invitee Staff name';
                  }
                  return null;
                },
                label: 'Staff Name',
                hintext: 'Enter the Invitee Staff name',
                controller: persontovisit,
              ),
              CustomTextField(
                  maxlength: 4,
                  sufficicon: const Icon(Icons.mode_of_travel),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter visting Department';
                    }
                    return null;
                  },
                  label: 'Department',
                  hintext: 'Enter the visiting Department',
                  controller: placeofvisit),
              CustomTextField(
                  maxlength: 4,
                  sufficicon: const Icon(Icons.assured_workload_rounded),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  label: 'Purpose of Visit',
                  hintext: 'Enter the purpose',
                  controller: purposeofvisit),
              CustomTextField(
                maxlength: 1,
                sufficicon: const Icon(Icons.person),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter the Invitee Staff name';
                //   }
                //   return null;
                // },
                label: 'Emergency Contact No',
                hintext: 'Enter the Emergency Contact No',
                controller: emergencyPhoneController,
              ),
              Center(
                child: SizedBox(
                  width: 800,
                  child: ListTile(
                    title: const Text('Terms & Conditions'),
                    trailing: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: termsConditons,
                      onChanged: (bool? value) {
                        setState(() {
                          termsConditons = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 800,
                  child: ListTile(
                    title: const Text('Do you have Covid certificate'),
                    trailing: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 800,
                  child: ListTile(
                    title: const Text('Approve this Conditions'),
                    trailing: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: approved,
                      onChanged: (bool? value) {
                        setState(() {
                          approved = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      await addVisitor({
                        "Name": nameController.text,
                        "nricFin": nricFin.text,
                        "CompanyName": companyNameController.text,
                        "designation": designation.text,
                        "Phone": phoneController.text,
                        "Email": emailController.text,
                        // "Location": locationController.text,
                        "persontovisit": persontovisit.text,
                        "placetovisit": placeofvisit.text,
                        "purpose": purposeofvisit.text,
                        "inTime": inTime.text,
                        "emergencyContact": emergencyPhoneController.text,
                        "isHave-covidcertificate": isChecked,
                        "termsCondition": termsConditons,
                        "approved": approved,
                      }).whenComplete(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      name: nameController.text,
                                      nricFin: nricFin.text,
                                      companyName: companyNameController.text,
                                      designation: designation.text,
                                      phone: phoneController.text,
                                      person: persontovisit.text,
                                      place: placeofvisit.text,
                                      purpose: purposeofvisit.text,
                                      inTime: inTime.text,
                                    )));
                      });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,bottom: 10
                ),
                child: Text('Powered by '),
              ),
              Image.network(
                'https://www.digisailor.com/assets/img/digisailorlogo.png',
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      required this.hintext,
      this.controller,
      this.validator,
      this.sufficicon,
      this.maxlength,
      this.inputFormatters})
      : super(key: key);

  final String label;
  final String hintext;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? sufficicon;
  final int? maxlength;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.10, vertical: 10),
      child: TextFormField(
        inputFormatters: inputFormatters,
        maxLines: maxlength,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: sufficicon,
            label: Text(label),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: hintext,
            fillColor: Colors.white70),
      ),
    );
  }
}
