import 'package:flutter/material.dart';

class SuperAppBar extends AppBar {
  SuperAppBar({
    super.key,
    // required this.isLoggedIn,
    required this.currentTitle,
    required this.setCurrentTitle,
  });

  final String currentTitle;
  // final bool isLoggedIn;
  final Function setCurrentTitle;

  @override
  State<SuperAppBar> createState() => _SuperAppBarState();
}

class _SuperAppBarState extends State<SuperAppBar> {
  // String currentTitle = 'Home';
  // void setCurrentTitel(String title) {
  //   setState(() => currentTitle = title);
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(widget.currentTitle),
        elevation: 0,
        actions: <Widget>[
          FilledButton(
            onPressed: () => widget.setCurrentTitle('Bsd'),
            child: const Row(children: [
              Text("Set Title to BLUB"),
              Icon(Icons.person),
            ]),
          ),
          FilledButton(
            onPressed: () => widget.setCurrentTitle('BLA'),
            child: const Row(children: [
              Text("Set Title to BLA"),
              Icon(Icons.person),
            ]),
          )
        ]);
  }
}

