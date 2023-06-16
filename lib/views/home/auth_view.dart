import 'package:flutter/material.dart';
import 'package:flutterapp/trash/register.dart';
import 'package:flutterapp/trash/sign_in.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool showSignIn = false;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? 
    SignIn(toggleView: toggleView) : 
    Register(toggleView: toggleView);
  }
}

