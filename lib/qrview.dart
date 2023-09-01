

import 'package:flutter/material.dart';

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';



class QRviewpage extends StatefulWidget {
  const QRviewpage({Key? key}) : super(key: key);

  @override
  State<QRviewpage> createState() => _QRviewpageState();
}

class _QRviewpageState extends State<QRviewpage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();

    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
 @override
  void initState(){

    controller?.flipCamera();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Please scan your QR code here'),

      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(

              key: qrKey,
              onQRViewCreated: _onQRViewCreated,

              overlay: QrScannerOverlayShape(



                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 20,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width*0.8
              ),

            ),
          ),


        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        // this.controller?.pauseCamera();

        result = scanData;


        showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            
            
            return AlertDialog(
              title: const Text('Please verify your QR code'),
              content:  SizedBox(
                height: 300,
                width: 300,
                child: Card(
                  child: Center(
                      child:Text(

                          '${result?.code}  Have been verified \n Digisailor welsomes you to Thuditssia'

                      )
                  ),




                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {




                    await controller.resumeCamera();



                    Navigator.pop(context, 'cancel');






                  } ,
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await controller.resumeCamera();


                    Navigator.pop(context, 'OK');

                  } ,
                  child: const Text('OK'),
                ),
              ],
            );



            
            
          }
        );

 await Future.delayed(Duration(seconds: 5));


        Navigator.pop(context, 'cancel');



      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
