import 'package:flutter/material.dart';
import 'package:flutterapp/modules/sign_me.dart';
import 'package:flutterapp/modules/signature_taker.dart';
import 'package:flutterapp/trash/sign_in.dart';
import 'package:mb_contact_form/mb_contact_form.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  @override
  Widget build(BuildContext context) {
    return const SignMe();
    // const MBContactForm(
    //     withIcons: true, destinationEmail: 'somemail@server.com');
  }
}
