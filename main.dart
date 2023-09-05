import 'package:flutter/material.dart';

import 'package:study/screens/Login.dart';
import 'package:study/screens/designpage.dart';
import 'package:study/screens/home_screen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/designpage': (context)=> DesignPageState(),
        '/home_screen': (context)=> HomeScreen(),


      },
    );
  }
}

