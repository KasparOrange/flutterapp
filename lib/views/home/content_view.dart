import 'package:flutter/material.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key, required this.child});

  final Widget child;

  // NOTE: This is a frame and backgroud for all pages. Widgets get wrapped in this in the RouteService. 
  // NOTE: file:///C:/SELF/Code/Flutter/flutterapp/lib/services/route_service.dart
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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