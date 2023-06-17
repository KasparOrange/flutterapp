import 'package:flutter/material.dart';

class PostsShowcase extends StatelessWidget {
  const PostsShowcase({super.key, required this.title});

  final String title;

  // NOTE: This is a placeholder for posts eventually retreied from a DB.
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          List.generate(10, (index) {
        if (index == 0) {
          return Center(
              child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
          ));
        } else {
          return const Text(
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.");
        }
      }),
    );
  }
}
