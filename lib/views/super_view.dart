import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/database_service.dart';
import 'package:flutterapp/services/keyboard_service.dart';
import 'package:flutterapp/services/logging_service.dart';
import 'package:flutterapp/services/route_service.dart';
import 'package:flutterapp/services/theme_service.dart';
import 'package:flutterapp/trash/app_bar_user_area.dart';
import 'package:flutterapp/views/content_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SuperView extends StatefulWidget {
  const SuperView({super.key, required this.child});

  final Widget child;

  @override
  State<SuperView> createState() => _SuperViewState();
}

class _SuperViewState extends State<SuperView> {
  var currentTitle = 'Home';
  void setCurrentTitel(title) {
    setState(() => currentTitle = title);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final routeService = Provider.of<RouteSerivce>(context);
    final keyboardService = Provider.of<KeyboardService>(context);
    final themeService = Provider.of<ThemeService>(context);
    final databaseService = Provider.of<DatabaseService>(context);
    // keyboardservice.injectContext(context);
    return KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) => keyboardService.keyHandler(
            event: event, context: context, themeService: themeService),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Lebenswertes Rügen',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            leadingWidth:
                426, // TODO: Make this depend on the size of the buttons. MaterialButton min width 88. Make TextButtonStyle so.
            leading: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: routeService.routePaths.map((e) {
                  Color? color;
                  Widget child;
                  if (e == GoRouter.of(context).location) {
                    color = Colors.amber;
                  }
                  if (e == '/') {
                    child = Image.asset(
                      'LebensWertesRuegen_Logo1.png',
                      color: Colors.black,
                    );
                  } else {
                    child = Text(routeService.titleFormRoutePath(e));
                  }
                  return MaterialButton(
                    onPressed: () => context.go(e),
                    color: color,
                    child: child,
                  );
                }).toList()),
            actions: [
              MaterialButton(
                onPressed: databaseService.test,
                child: const Text('TEST'),
              ),
              const Tooltip(
                  message: 'SHIFT + J = Left\nSHIFT + K = Right',
                  child: Icon(Icons.keyboard)),
              MaterialButton(
                onPressed: () {
                  themeService.toggleThemeMode();
                  log(themeService.themeMode);
                },
                child: themeService.themeMode == ThemeMode.light
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode_sharp),
              ),
              const AppBarUserArea()
            ],
          ),
          body: Stack(children: [
            Container(
              height: 1000,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('kreidekueste-ruegen.jpg'),
                      opacity: 0.2,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Colors.transparent
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  backgroundBlendMode: BlendMode.darken),
            ),
            ListView(
                controller: routeService.scrollController,
                addSemanticIndexes: true,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                children: [
                  Container(
                    height: 500,
                  child:
                  widget.child,
                  // NOTE: Comes from: file:///C:/SELF/Code/flutter/flutterapp/lib/services/route_service.dart

                    ),
                  Container(
                    color: Colors.amber,
                    height: 200,
                  ),
                ]),
          ]),
        ));
  }
}
