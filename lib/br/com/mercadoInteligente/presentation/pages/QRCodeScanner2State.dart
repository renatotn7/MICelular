
import 'dart:async';
import 'dart:collection';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/data/models/Empresa.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/data/remote/EmpresaRemote.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/manager/NFStatefull.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/manager/QRCodeScanner2Statefull.dart';
import 'package:qrcode/qrcode.dart';
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom; // Contains DOM related classes for
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import '../../../../../main.dart' as main;
//import 'br/com/mercadoInteligente/data/models/Empresa.dart';
//import 'br/com/mercadoInteligente/data/remote/EmpresaRemote.dart';
//import 'br/com/mercadoInteligente/presentation/manager/home_page.dart';
import 'package:flutter/services.dart';
class QRCodeScanner2State extends State<QRCodeScanner2> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Barcode Scanner Example'),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new MaterialButton(
                      onPressed: scan, child: new Text("Scan")),
                  padding: const EdgeInsets.all(8.0),
                ),
                new Text(barcode),
              ],
            ),
          )),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print(barcode);
      main.selectedUrl=barcode;
      main.scannedUrl=barcode;
      Navigator.pushNamed(context,
          NFStatefull.routeName);
    //  setState(() => this.barcode = barcode);

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}