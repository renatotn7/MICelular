import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/manager/QRHomePage.dart';
import 'package:qrcode/qrcode.dart';
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom; // Contains DOM related classes for
class QRHomePageState extends State<QRHomePage> {
  QRCaptureController _captureController = QRCaptureController();

  bool _isTorchOn = false;

  @override
  void initState() {
    super.initState();

    _captureController.onCapture((data) {
      print('onCapture----$data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[QRCaptureView(controller: _captureController),
            GridView.count(
              //cria um grid com 2 colunas
              crossAxisCount: 3,
              // Gera 100 Widgets que exibem o seu índice na lista
              children: List.generate(18, (index) {
                return index==7?Text(
                  ' ',
                  style: Theme.of(context).textTheme.headline,
                ):Container(
                  color:Colors.white,
                  child: Text(
                    ' ',
                    style: Theme.of(context).textTheme.headline,
                  ),
                ); ;
              }),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: _buildToolBar(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToolBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            _captureController.pause();
          },
          child: Text('pause'),
        ),
        FlatButton(
          onPressed: () {
            if (_isTorchOn) {
              _captureController.torchMode = CaptureTorchMode.off;
            } else {
              _captureController.torchMode = CaptureTorchMode.on;
            }
            _isTorchOn = !_isTorchOn;
          },
          child: Text('torch'),
        ),
        FlatButton(
          onPressed: () {
            _captureController.resume();
          },
          child: Text('resume'),
        ),
      ],
    );
  }
}