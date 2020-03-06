import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/data/models/Empresa.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/data/remote/EmpresaRemote.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/manager/NFStatefull.dart';
import 'package:qrcode/qrcode.dart';
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom; // Contains DOM related classes for
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
//import 'br/com/mercadoInteligente/data/models/Empresa.dart';
//import 'br/com/mercadoInteligente/data/remote/EmpresaRemote.dart';
//import 'br/com/mercadoInteligente/presentation/manager/home_page.dart';
import '../../../../../main.dart' as main;
class NFState extends State<NFStatefull> {
  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onProgressChanged;

  StreamSubscription<double> _onScrollYChanged;

  StreamSubscription<double> _onScrollXChanged;

  final _urlCtrl = TextEditingController(text: main.selectedUrl);

  final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  @override
  void initState() {
    print(main.scannedUrl);
    super.initState();

    flutterWebViewPlugin.close();
    opennfhidenn();
    _urlCtrl.addListener(() {
      main.selectedUrl = _urlCtrl.text;
    });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Webview Destroyed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
          if (mounted) {
            setState(() {
              _history.add('onProgressChanged: $progress');
            });
          }
        });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
          if (mounted) {
            setState(() {
              _history.add('Scroll in Y Direction: $y');
            });
          }
        });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
          if (mounted) {
            setState(() {
              _history.add('Scroll in X Direction: $x');
            });
          }
        });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          if (mounted) {
            setState(() {
              _history.add('onStateChanged: ${state.type} ${state.url}');
            });
          }
        });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
          if (mounted) {
            setState(() {
              _history.add('onHttpError: ${error.code} ${error.url}');
            });
          }
        });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              child: TextField(controller: _urlCtrl),
            ),
            RaisedButton(
              onPressed: () {
                flutterWebViewPlugin.launch(
                  main.scannedUrl,
                  rect: Rect.fromLTWH(
                      0.0, 0.0, MediaQuery.of(context).size.width, 300.0),
                  userAgent: main.kAndroidUserAgent,
                  invalidUrlRegex:
                  r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
                );
              },
              child: const Text('Open Webview (rect)'),
            ),
            RaisedButton(
              onPressed: () {
                flutterWebViewPlugin.launch(main.selectedUrl, hidden: true);
              },
              child: const Text('Open "hidden" Webview'),
            ),
            RaisedButton(
              onPressed: () {
                flutterWebViewPlugin.launch(main.selectedUrl);
              },
              child: const Text('Open Fullscreen Webview'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/widget');
              },
              child: const Text('Open widget webview'),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              child: TextField(controller: _codeCtrl),
            ),
            RaisedButton(
              onPressed:avaliar,
              child: const Text('Eval some javascript'),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _history.clear();
                });
                flutterWebViewPlugin.close();
              },
              child: const Text('Close'),
            ),
            RaisedButton(
              onPressed: () {
                flutterWebViewPlugin.getCookies().then((m) {
                  setState(() {
                    _history.add('cookies: $m');
                  });
                });
              },
              child: const Text('Cookies'),
            ),
            Text(_history.join('\n'))
          ],
        ),
      ),
    );
  }
 Future opennfhidenn() async{
 await flutterWebViewPlugin.launch(

    main.scannedUrl,
   hidden:true,
  /*  rect: Rect.fromLTWH(
        0.0, 0.0, MediaQuery.of(context).size.width, 300.0),*/
    userAgent: main.kAndroidUserAgent,
    invalidUrlRegex:
    r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
  );
 Future.delayed(Duration(seconds: 3,), () async {
   await avaliar();
 });
}

 Future avaliar () async  {
  final future =
  flutterWebViewPlugin.evalJavascript("\$('#btnVisualizarAbas').trigger('click');");
  future.then((String result) {
  setState(() {

  _history.add('eval: $result');
  });


  Future.delayed(Duration(seconds: 3,), () async {
    Future.delayed(Duration(seconds: 6,), () async {
      flutterWebViewPlugin.close();
    });
  Empresa e =  Empresa();
  final future2 = await flutterWebViewPlugin.evalJavascript(
  "\$('#NFe > fieldset:nth-child(2) > table > tbody > tr > td:nth-child(1) > span').text();").
  then((String result) {
  e.cnpj=result;
  print('cnpj' + result);
  });
  await flutterWebViewPlugin.evalJavascript(
  "\$('#NFe > fieldset:nth-child(2) > table > tbody > tr > td.col-2 > span').text();").
  then((String result) {
  e.razaoSocial=result;
  print('raz soc' + result);
  });
  await flutterWebViewPlugin.evalJavascript(
  "\$('#NFe > fieldset:nth-child(2) > table > tbody > tr > td:nth-child(3) > span').text();").
  then((String result) {
  e.ie=result;
  print('raz soc' + result);
  });
  await  flutterWebViewPlugin.evalJavascript(
  "\$('#NFe > fieldset:nth-child(2) > table > tbody > tr > td.col-10 > span').text();").
  then((String result) {
  e.rua=result;
  print('raz soc' + result);
  });
  await flutterWebViewPlugin.evalJavascript(
  "\$('#Emitente > fieldset > table > tbody > tr:nth-child(3) > td:nth-child(1) > span').text();").
  then((String result) {
  e.bairro=result;
  print('raz soc' + result);
  });
  await  flutterWebViewPlugin.evalJavascript(
  "\$('#Emitente > fieldset > table > tbody > tr:nth-child(4) > td:nth-child(1) > span;").
  then((String result) {
  e.municipio=result;
  print('raz soc' + result);
  });
  await flutterWebViewPlugin.evalJavascript(
  "\$('#Emitente > fieldset > table > tbody > tr:nth-child(5) > td:nth-child(1) > span').text();").
  then((String result) {
  e.uf=result;
  print('raz soc' + result);
  });
  ;
  EmpresaRemote eremote = EmpresaRemote();
  await eremote.enviar( e);
  });

  getProd(var i) {
  var ititle=(i+1).toString();
  var ivalues=(i+2).toString();

  Future.delayed(Duration(seconds: 3,), () {

  //dados da nota fiscal
  //#NFe > fieldset:nth-child(1) > table > tbody > tr > td:nth-child(1) > span modelo

  //serie #NFe > fieldset:nth-child(1) > table > tbody > tr > td:nth-child(1) > span
  //#pnlDadosNFCeId > table > tbody > tr:nth-child(2) > td:nth-child(2) numero nfce
  //versao  #pnlDadosNFCeId > table > tbody > tr:nth-child(2) > td:nth-child(3)
  //codigo de acesso : #pnlDadosNFCeId > table > tbody > tr:nth-child(2) > td:nth-child(1)
  //data #NFe > fieldset:nth-child(1) > table > tbody > tr > td:nth-child(4) > span


  //emitente
  // #NFe > fieldset:nth-child(2) > table > tbody > tr > td:nth-child(1) > span  cnpj
  // #NFe > fieldset:nth-child(2) > table > tbody > tr > td.col-2 > span razao social
  // #NFe > fieldset:nth-child(2) > table > tbody > tr > td:nth-child(3) > span ie
  // #NFe > fieldset:nth-child(2) > table > tbody > tr > td.col-10 > span uf
  //<span>AVENIDA LUIS CARLOS BERRINI,&nbsp;
  //                1493&nbsp;
  //                </span> endereço
  //#Emitente > fieldset > table > tbody > tr:nth-child(3) > td:nth-child(1) > span bairro
  //#Emitente > fieldset > table > tbody > tr:nth-child(5) > td:nth-child(1) > span uf
  //#Emitente > fieldset > table > tbody > tr:nth-child(4) > td:nth-child(1) > span municipio



  //destinatario:
  //#pnlDadosNFCeId > table > tbody > tr:nth-child(2) > td:nth-child(1) cpf

  final future2 = flutterWebViewPlugin.evalJavascript(
  "\$('#Prod > fieldset > div > table:nth-child($ititle) > tbody > tr > td.fixo-prod-serv-descricao > span').text();").
  then((String result) {
  print('###***___' + result);
  });

  flutterWebViewPlugin.evalJavascript(
  "\$('#Prod > fieldset > div > table:nth-child($ititle) > tbody > tr > td.fixo-prod-serv-qtd > span').text();")
      .then((String result) {
  print('###***___' + result);
  });

  flutterWebViewPlugin.evalJavascript(
  "\$('#Prod > fieldset > div > table:nth-child($ititle) > tbody > tr > td.fixo-prod-serv-uc > span').text();")
      .then((String result) {
  print('###***___' + result);
  });

  flutterWebViewPlugin.evalJavascript(
  "\$('#Prod > fieldset > div > table:nth-child($ititle) > tbody > tr > td.fixo-prod-serv-vb > span').text();")
      .then((String result) {
  print('###***___' + result);
  });

  flutterWebViewPlugin.evalJavascript(
  "\$('#Prod > fieldset > div > table:nth-child($ivalues) > tbody > tr > td > table:nth-child(1) > tbody > tr.col-4 > td:nth-child(1) > span').text();")
      .then((String result) {
  print('###***cprod' + result);
  });

  flutterWebViewPlugin.evalJavascript(
  "\$('#Prod > fieldset > div > table:nth-child($ivalues) > tbody > tr > td > table:nth-child(1) > tbody > tr.col-4 > td:nth-child(2) > span').text();")
      .then((String result) {
  print('###***ncm' + result);
  });

  flutterWebViewPlugin.evalJavascript(
  "\$('#Prod > fieldset > div > table:nth-child($ivalues) > tbody > tr > td > table:nth-child(1) > tbody > tr.col-4 > td:nth-child(3) > span').text();")
      .then((String result) {
  print('###***cest' + result);
  });
  flutterWebViewPlugin.evalJavascript(
  "\$('##Prod > fieldset > div > table:nth-child($ivalues) > tbody > tr > td > table:nth-child(3) > tbody > tr.col-3 > td:nth-child(1) > span').text();")
      .then((String result) {
  print('###***ean' + result);
  });

  });
  };
  var prodi=1;
  getProd(prodi);
  prodi=prodi+2;
  getProd(prodi);

  });

  }
}

