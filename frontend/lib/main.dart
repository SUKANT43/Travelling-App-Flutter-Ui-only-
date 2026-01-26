import 'package:flutter/material.dart';
import 'package:frontend/page/forgot_password_page.dart';
import './page/login_page.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login":(context)=>const LoginPage(),
        "/forgotpassword":(context)=>const ForgotPasswordPage()
      },
    );
  }
}