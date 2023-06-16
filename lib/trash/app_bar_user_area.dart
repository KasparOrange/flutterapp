import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppBarUserArea extends StatelessWidget {
  const AppBarUserArea({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          
            // style: ButtonStyle(
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //           RoundedRectangleBorder(
            //               borderRadius: BorderRadius.zero,
            //               // side: BorderSide(color: Colors.red),
            //               ))),
          
          onPressed: () {
            context.go('/auth');
            if (user != null) {
              // route either to the signIn page or to the profile page
            }
          },
          child: const Icon(Icons.person_3),
        )
      ],
    );
  }
}
