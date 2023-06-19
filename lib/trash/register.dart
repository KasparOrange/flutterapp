import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth_service.dart';
import 'package:flutterapp/services/logging_service.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String error = '';
  String password = '';

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text("Register"), actions: [
        FilledButton(
          onPressed: () {
            widget.toggleView();
          },
          child: const Row(
            children: [
              Text("Sing In"),
              Icon(Icons.person),
            ],
          ),
        )
      ]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 300),
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
                    validator: (value) => _authService.validateEmail(value),
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
                  validator: (value) => _authService.validatePassword(value),
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _authService
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Fehler beim Registrieren';
                          });
                        }
                        log(email);
                        log(password);
                      }
                    },
                    child: const Text("Register")),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
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
