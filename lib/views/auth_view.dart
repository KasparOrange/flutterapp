import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_service.dart';
import 'package:flutterapp/services/logging_service.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool showSignIn = false;
  bool loading = false;
  String email = '';
  String error = '';
  String password = '';
  final _formStateGK = GlobalKey<FormState>();

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  Widget _buildElevatedButton(AuthService authService) {
    return switch (authService.authViewToShow) {
      AuthViewToShow.ShowRegister => ElevatedButton(
          onPressed: () async {
            if (_formStateGK.currentState!.validate()) {
              dynamic result = await authService.registerWithEmailAndPassword(
                  email, password);
              if (result == null) {
                setState(() {
                  error = 'Fehler beim Registrieren';
                });
              }
            }
          },
          child: const Text("Register")),
      AuthViewToShow.ShowSignIn => ElevatedButton(
          onPressed: () async {
            if (_formStateGK.currentState!.validate()) {
              log('Loading: $loading');
              setState(() => loading = true);
              dynamic result =
                  await authService.signInWithEmailAndPassword(email, password);
              if (result == null) {
                log('Loading: $loading');
                setState(() {
                  error = 'Damit kann ich dich nicht anmelden';
                  loading = false;
                });
              }
            }
          },
          child: const Text('Sign In')),
      AuthViewToShow.ShowSignOut => ElevatedButton(
          onPressed: () async => await authService.signOut(),
          child: const Text('Sign Out')),
    };
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    if (authService.user == null) {
      return _buildElevatedButton(authService);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 300),
        child: Form(
            key: _formStateGK,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined)),
                    validator: (value) => authService.validateEmail(value),
                    onChanged: (value) {
                      setState(() => email = value);
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.key_outlined)),
                  obscureText: true,
                  validator: (value) => authService.validatePassword(value),
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                )
              ],
            )),
      );

      // NOTE: Old way.
      // showSignIn ?
      // SignIn(toggleView: toggleView) :
      // Register(toggleView: toggleView);
    }
  }
}
