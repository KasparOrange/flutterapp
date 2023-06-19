import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_service.dart';
import 'package:flutterapp/services/logging_service.dart';
import 'package:flutterapp/modules/loading_module.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String error = '';
  String password = '';

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingModule()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("Sign in LOL"),
              actions: [
                FilledButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.person),
                        Text("Register"),
                      ],
                    ))
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 300),
              child: Form(
                  key: _formKey,
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
                          validator: (value) =>
                              _authService.validateEmail(value),
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
                        validator: (value) =>
                            _authService.validatePassword(value),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  log('Loading: $loading');
                                  setState(() => loading = true);
                                  dynamic result = await _authService
                                      .signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    log('Loading: $loading');
                                    setState(() {
                                      error =
                                          'Damit kann ich dich nicht anmelden';
                                      loading = false;
                                    });
                                  }
                                  log(email);
                                  log(password);
                                }
                              },
                              child: const Text("Sign In with E&P")),
                          ElevatedButton(
                              onPressed: () async {
                                log('Loading: $loading');
                                setState(() => loading = true);
                                await _authService.signInAnonymously();
                              },
                              child: const Text("Sign In anon")),
                        ],
                      )
                    ],
                  )),
            ),
            floatingActionButton: IconButton(
              icon: const Icon(Icons.nature),
              onPressed: () {},
            ),
          );
  }
}
