import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';



class QRPage extends StatefulWidget {
  const QRPage({Key? key, required this.profile}) : super(key: key);



  final Map<String,dynamic> profile;

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(




      body: Center(


        child: SizedBox(
          height: 100,
          width: 200,
          child: Card(
            child: QrImageView(


              data:

           widget.profile.toString()



              ,




            ),




          ),
        ),


      ),





    );
  }
}
