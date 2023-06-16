import 'package:flutter/material.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      margin: const EdgeInsets.all(50),
      padding: const EdgeInsets.symmetric(horizontal: 100),
      decoration: BoxDecoration(
          border: Border.symmetric(
              vertical:
                  BorderSide(color: Theme.of(context).dividerColor, width: 6),
              horizontal:
                  BorderSide(color: Theme.of(context).dividerColor, width: 6)),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background),
      child: child,
    );
  }
}