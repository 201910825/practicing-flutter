/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // Firebase Authentication 로그인 작업 수행
              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
              print('로그인 성공: ${userCredential.user!.uid}');
            } catch (e) {
              print('로그인 오류: $e');
            }
          },
          child: Text('로그인'),
        ),
      ),
    );
  }
}*/