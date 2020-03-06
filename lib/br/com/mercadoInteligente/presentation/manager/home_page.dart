import 'package:flutter/material.dart';
import 'package:mercado_inteligente/br/com/mercadoInteligente/presentation/pages/MapUi.dart';
import '../../domain/entities/Module.dart';
/*import '../pages/navigationDrawer/NavigationDrawerHome.dart';
import '../pages/tabView/TabviewHome.dart';
import '../pages/mapWithPlots/MapUi.dart';
import '../pages/authenticationModule/AuthenticationHome.dart';
import '../pages/tinderSwipeOne/TinderSwipeOne.dart';
import '../pages/tinderSwipeTwo/TinderSwipeTwo.dart';
import '../pages/introScreensModule/IntroScreensHomePage.dart';*/

class HomePage extends StatelessWidget {
  String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Sanra',
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: ModuleSelectionScreen(),
    );
  }
}

class ModuleSelectionScreen extends StatefulWidget {
  @override
  StarterKitMenu createState() => new StarterKitMenu();
}

class StarterKitMenu extends State<ModuleSelectionScreen> {
  var modulesList = new List<Module>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          itemCount: modulesList.length,
          itemBuilder: (context, index) {
            return getItemWidet(index);
          },
        ));
  }

  Widget getItemWidet(int index) {
    return new GestureDetector(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Text(modulesList[index].moduleName),
          ),
        ),
        onTap: () {
          checkNavigation(modulesList[index].moduleName);
        });
  }

  void checkNavigation(String moduleName) {
    /*if (moduleName == "Navigation Drawer") {
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigationDrawerApp()),
      );
    } else if (moduleName == "Tab View") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabViewHome()),
      );
    } else */ if (moduleName == "Map with Plots") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapUi()),
      );
    }/* else if (moduleName == "Biometric Authentication") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthenticationHome()),
      );
    }else if(moduleName == "Tinder One"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => TinderSwipeOne()),);
    }else if(moduleName == "Tinder Swipe Two"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => TinderSwipeTwo()),);
    }else if(moduleName == "Intro Screens"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreenHomePage()));
    }*/
  }

  @override
  void initState() {
    super.initState();
    createModuleList();
  }

  void createModuleList() {
    Module module = new Module();
    module.id = "1";
    module.moduleName = "Intro Screens";

    modulesList.add(module);


    module = new Module();
    module.id = "2";
    module.moduleName = "Biometric Authentication";

    modulesList.add(module);

    module = new Module();
    module.id = "3";
    module.moduleName = "Navigation Drawer";

    modulesList.add(module);

    module = new Module();
    module.id = "4";
    module.moduleName = "Tinder One";

    modulesList.add(module);

    module = new Module();
    module.id = "5";
    module.moduleName = "Tab View";

    modulesList.add(module);

    module = new Module();
    module.id = "6";
    module.moduleName = "Map with Plots";

    modulesList.add(module);


    module = new Module();
    module.id = "7";
    module.moduleName = "Tinder Swipe Two";

    modulesList.add(module);




  }
}
