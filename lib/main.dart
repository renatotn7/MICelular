import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/manager/NFStatefull.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/manager/QRHomePage.dart';
import 'package:qrcode/qrcode.dart';
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom; // Contains DOM related classes for
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'br/com/mercadoInteligente/data/models/Empresa.dart';
import 'br/com/mercadoInteligente/data/remote/EmpresaRemote.dart';
import 'br/com/mercadoInteligente/presentation/manager/QRCodeScanner2Statefull.dart';
import 'br/com/mercadoInteligente/presentation/manager/home_page.dart';
// FlutterWebviewPlugin flutterWebviewPlugin;


const kAndroidUserAgent =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36';

String selectedUrl = '';//'https://www.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx?p=35200245543915062969650010003006511891341547|2|1|4|2AAB461BEA58205728EAEC785C4C9A62A0C265FB';
String scannedUrl;
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  final availableMaps = await MapLauncher.installedMaps;
print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
  //var client = Client();
 // Response response = await client.get(
  //    'https://www.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx?p=35200245543915062969650010003006511891341547|2|1|4|2AAB461BEA58205728EAEC785C4C9A62A0C265FB'
 // );
  /*final FlutterWebviewPlugin  flutterWebviewPlugin = new FlutterWebviewPlugin();
 Map<String,String> hashMap = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36'};
  //_launchURL();
  flutterWebviewPlugin.launch('https://www.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx?p=35200245543915062969650010003006511891341547|2|1|4|2AAB461BEA58205728EAEC785C4C9A62A0C265FB',
      hidden: false,
      userAgent:'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36',
      rect: Rect.fromLTRB(0, 0, 0, 40)
  );
  // wait for jquery to be loaded
  //await Future.delayed(Duration(milliseconds: 15000));
  flutterWebviewPlugin.onStateChanged.listen( (viewState) async {

    if (viewState.type == WebViewState.finishLoad) {

      print('oioioioio'+await flutterWebviewPlugin.evalJavascript( "\$('#btnVisualizarAbas').trigger('click');"));
   //   String result1 = await flutterWebviewPlugin.evalJavascript(
     //     "\$('body').html();");
     // print('************resultado1:' + result1);
      flutterWebviewPlugin.onStateChanged.listen( (viewState) async {
        if (viewState.type == WebViewState.finishLoad) {

            await flutterWebviewPlugin.evalJavascript( "\$('#btnVisualizarAbas').trigger('click');");
            String result3 = await flutterWebviewPlugin.evalJavascript(

                "\$('('table').html();");

            print('##############resultado:' + result3);




        }
      });
    }

  });*/

  // prints the body html

  //print(response.body);

}

class MyApp extends StatelessWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var routes = <String, WidgetBuilder>{
      NFStatefull.routeName: (BuildContext context) =>
      new NFStatefull(),
      QRCodeScanner2.routeName: (BuildContext context) =>
      new QRCodeScanner2(),
    };
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes:routes /*{

        '/widget': (_) {
          return WebviewScaffold(
            userAgent: kAndroidUserAgent,
            url: selectedUrl,
            javascriptChannels: jsChannels,
            mediaPlaybackRequiresUserGesture: false,
            appBar: AppBar(
              title: const Text('Widget WebView'),
            ),
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.redAccent,
              child: const Center(
                child: Text('Waiting.....'),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goBack();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goForward();
                    },
                  ),
                  Expanded (child:Container(
                      margin:
                      new EdgeInsets.only(right: 10.0, left: 10),

                      child:TextFormField(
                        textCapitalization: TextCapitalization.words,

                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          icon: Icon(Icons.mail),
                          hintText: "Email",
                          labelText: "Email",
                        ),
                        onSaved: (value) {
                          print(value);
                          //  person.name = value;
                        },
                        // validator: _validateName,
                      ))),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    onPressed: () {
                      flutterWebViewPlugin.reload();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      }*/,
    //  home: QRHomePage(),
      home:QRCodeScanner2(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MapLauncherDemo createState() => MapLauncherDemo();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("oi"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class MapLauncherDemo extends State<MyHomePage> {
  openMapsSheet(context) async {
    try {
      final title = "Shanghai Tower";
      final description = "Asia's tallest building";
      final coords = Coords(31.233568, 121.505504);
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(

                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Launcher Demo'),
        ),
        body: Center(child: Container(
          child : RaisedButton(
              onPressed: () => openMapsSheet(context),
              child: Text('Show Maps'),
            )
          ,
        )),
      );

  }
}




Future<void> _launchURL() async {
  try {
    Map<String,String> hashMap = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36'};

    await launch(
      'https://www.nfce.fazenda.sp.gov.br/NFCeConsultaPublica/Paginas/ConsultaQRCode.aspx?p=35200245543915062969650010003006511891341547|2|1|4|2AAB461BEA58205728EAEC785C4C9A62A0C265FB',

      option: CustomTabsOption(
        headers:hashMap,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        animation: CustomTabsAnimation.slideIn(),
        extraCustomTabs: const <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
        ],
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}