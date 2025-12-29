import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p1/firebase_options.dart';
import 'package:p1/models/restaurant.dart';
import 'package:p1/pages/login_page.dart';
import 'package:p1/pages/register_page.dart';
import 'package:p1/service/auth/auth_gate.dart';
import 'package:p1/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
   MultiProvider(
       providers:[
   //theme
         ChangeNotifierProvider(create: (_) => ThemeProvider()),
         ChangeNotifierProvider(create: (_) => Restaurant()),
    // restaurant
],
     child: const MyApp(),
   )
  );
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}