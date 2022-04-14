import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/model/ttheme_model.dart';
import 'package:travel_app/pages/homepage.dart';
import 'package:travel_app/travel_provider/travel_provider.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeModel themeModel = ThemeModel();
  bool? lights = true;
  ThemeData _lightTheme = ThemeData(
    primaryColor: Colors.green,
    hintColor: Colors.white,
  );

  ThemeData _darktheme = ThemeData(
    primaryColor: Colors.black,
    hintColor: Colors.white,
  );

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   lights=themeModel.light;
  // }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TravelProvider()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.green,
              hintColor: Colors.white,
            ),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
