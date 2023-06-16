import 'package:flutter/material.dart';
import 'package:flutterapp/models/user_model.dart';
import 'package:flutterapp/services/log_service.dart';
import 'package:flutterapp/views/home/auth_view.dart';
import 'package:flutterapp/views/home/home_view.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    log('$user');
    // Show either the HomeView or the AuthView based on signin status
    // return StreamBuilder<UserModel?>(builder: (context, snapshot) {

    // if (snapshot.hasData) {
    if (user == null) {
      return const AuthView();
    } else {
      return const HomeView();
    }
  }
}
