import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/pages/QRHomePageState.dart';
import 'package:qrcode/qrcode.dart';
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom; // Contains DOM related classes for
class QRHomePage extends StatefulWidget {
  QRHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final Map<String, dynamic> pluginParameters = {
  };

  @override
  QRHomePageState createState() => new QRHomePageState();
}