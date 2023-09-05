
import 'package:flutter/material.dart';
import 'package:study/screens/designpage.dart';
import 'package:study/screens/drag_design.dart';
import 'package:study/services/save_design.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu,color: Colors.black,)),
        title: Text("happycat",style: TextStyle(color: Colors.black),),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Colors.black,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none,color: Colors.black,)),
          IconButton(onPressed: () {Navigator.pushNamed(context, '/home_screen');}, icon: Icon(Icons.home_outlined,color: Colors.black,)),

        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/designpage');
          },
          child: Text('Go to Design Page'),
        ),
      ),
    );
  }
}

