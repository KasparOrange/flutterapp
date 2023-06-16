import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 600,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'FLUTTER WEB. \nTHE BASICS',
                style: TextStyle(
                    fontWeight: FontWeight.w800, height: 0.9, fontSize: 80),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'sdfjasdlkfjls;kadjfl;skajdf;l',
                style: TextStyle(fontSize: 21, height: 1.7),
              ),
            ]));
  }
}
