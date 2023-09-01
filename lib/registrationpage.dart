import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocregistrationform/qrview.dart';
import 'package:qr_flutter/qr_flutter.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController placeofvisit= TextEditingController();
  TextEditingController purposeofvisit = TextEditingController();
  TextEditingController persontovisit = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('Visitors');
  bool isChecked = false;

  Future<void> addVisitor(dynamic myData) {
    // Call the user's CollectionReference to add a new user
    return users.doc(phoneController.text).set(myData)
        .then((value) {

          if(isChecked==false){

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You will not allowed to visit without Covid certificate'),duration: Duration(seconds: 3),backgroundColor: Colors.red,));

          }else{
            showDialog<String>(
              context: context,
              builder: (BuildContext context ) => AlertDialog(
                title: const Text('Please verify your QR code'),
                content: SizedBox(
                  height: 300,
                  width: 300,
                  child: Card(
                    child: Center(
                      child: QrImageView(


                        data: nameController.text




                        ,




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

    }


    )
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
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
        return Colors.blue;
      }
      return Colors.red;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registration'),
        actions: [
          IconButton(onPressed: (){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRviewpage()),
            );


          }, icon: Icon(Icons.document_scanner_outlined))

        ],

      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [


              // Image.network('https://www.digisailor.com/assets/img/digisailorlogo.png',h),



              CustomTextField(
                sufficicon: Icon(Icons.person) ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                hintext: 'Enter Your Name',
                label: 'Name',
                controller: nameController,
              ),
              CustomTextField(
                sufficicon: Icon(Icons.mail) ,
                label: 'Email',
                hintext: 'name@gmail.com',
                controller: emailController,
              ),
              CustomTextField(
                sufficicon: Icon(Icons.location_pin) ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                label: 'Location',
                hintext: 'Enter Your Location',
                controller: locationController,
              ),
              CustomTextField(
                sufficicon: Icon(Icons.location_city_outlined) ,
                label: 'CompanyName',
                hintext: 'Enter Your organisation',
                controller: companyNameController,
              ),
              CustomTextField(
                sufficicon: Icon(Icons.phone) ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                label: 'Phone',
                hintext: '+9182633463',
                controller: phoneController,
              ),
              CustomTextField(
                maxlength: 1,
                sufficicon: Icon(Icons.person) ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Name';
                  }
                  return null;
                },
                label: 'Invitee Name',
                hintext: 'Enter the Invitee name',
                controller:persontovisit,
              ),
              CustomTextField(
                maxlength: 4,
                sufficicon: Icon(Icons.assured_workload_rounded) ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                label: 'Purpose of Visit',
                hintext: 'Enter the purpose',
                controller: purposeofvisit
              ),
              CustomTextField(
                maxlength: 4,
                sufficicon: Icon(Icons.mode_of_travel) ,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the place address';
                  }
                  return null;
                },
                label: 'Place of Visit',
                hintext: 'Enter the Address',
                controller: placeofvisit,
              ),
              Center(
                child: SizedBox(
                  width: 800,
                  child: ListTile(

                    title: Text('Do you have Covid certificate'),
                    trailing: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;

                      });
                    },
                  ),),
                ),
              ),
              ElevatedButton(
                
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)
                ),
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
                        "Email": emailController.text,
                        "Phone": phoneController.text,
                        "CompanyName": companyNameController.text,
                        "Location": locationController.text,
                          "purpose":purposeofvisit.text,
                   "placetovisit":placeofvisit.text,
                   "persontovisit":persontovisit.text,
                   "isHave-covidcertificate":isChecked,
                      });
                      //
                      // Navigator.pop(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => QRPage(
                      //               profile: {
                      //                 "Name": nameController.text,
                      //                 "Email": emailController.text,
                      //                 "Phone": phoneController.text,
                      //                 "CompanyName": companyNameController.text,
                      //                 "Location": locationController.text,
                      //               },
                      //             )));




                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Submit',style: TextStyle(color: Colors.black),),
                  )),


              Padding(
                padding: const EdgeInsets.only(top: 20,),
                child: Text('Powered by '),
              ),

              Image.network('https://www.digisailor.com/assets/img/digisailorlogo.png',height: 100,width: 100,),
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
      this.validator, this.sufficicon, this.maxlength})
      : super(key: key);

  final String label;
  final String hintext;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? sufficicon;
  final int? maxlength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.10,vertical: 10),
      child: TextFormField(
        maxLines: maxlength,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon:sufficicon ,
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
