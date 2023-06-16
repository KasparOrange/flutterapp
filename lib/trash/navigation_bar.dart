import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      width: 500,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _NavBarItem('Contact'),
        _NavBarItem('Products'),
        _NavBarItem('About'),
        // SizedBox(
        //   height: 120,
        //   width: 150,
        //   child: Image.asset('assets/logo.png'),
        // ),
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     mainAxisSize: MainAxisSize.max,
        //     children: const [
        // SizedBox(
        //   width: 60,
        // ),
      ]),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {  },
      child: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
