import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingModule extends StatelessWidget {
  const LoadingModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitFadingCircle(
      itemBuilder: (_, int index) {
        return const Icon(
          Icons.webhook_rounded,
          color: Colors.lightGreen,
        );
      },
      size: 130.0,
    ));
  }
}
