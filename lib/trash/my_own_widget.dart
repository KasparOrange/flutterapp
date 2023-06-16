import 'package:flutter/material.dart';

class MyOwnWidget extends StatelessWidget {
  const MyOwnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(30),
          child: Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(4),
            child: const Text("Second"),
          ),
        ),
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(30),
          child: Container(
            color: Colors.green,
            padding: const EdgeInsets.all(4),
            child: const Text("First"),
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          child: const Text("sadfl"),
        ),
        TextButton(onPressed: () {}, child: const Text("TextButton")),
      ],
    );
  }
}
