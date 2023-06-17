import 'package:flutter/material.dart';
import 'package:flutterapp/views/home/auth_view.dart';
import 'package:flutterapp/views/home/contact_view.dart';
import 'package:flutterapp/views/home/content_view.dart';
import 'package:flutterapp/views/home/super_view.dart';
import 'package:flutterapp/modules/markdown_editor_module.dart';
import 'package:flutterapp/modules/posts_showcase_module.dart';
import 'package:go_router/go_router.dart';

class RouteSerivce {
  int currentRouteIndex = 0;

  ScrollController scrollController = ScrollController();

  List<String> routePaths = [
    '/',
    '/aktuelles',
    '/kontakt',
    '/markdowntest',
    '/auth',
  ];

  Widget _getChild(String path) {
    // final path = routePaths[index];
    switch (path) {
      case '/':
        return Image.asset('kreidekueste-ruegen.jpg', fit: BoxFit.fitWidth, alignment: Alignment.topCenter,);
      case '/aktuelles':
        return ContentView(
            child: PostsShowcase(title: titleFormRoutePath(path)));
      case '/kontakt':
        return const ContentView(child: ContactView());
      case '/markdowntest':
        return const ContentView(child: MarkdownEditorModule());
      case '/auth':
        return const ContentView(child: AuthView());
      default:
        return const ContentView(
            child: Text('ERROR',
                style: TextStyle(
                  color: Colors.red,
                )));
    }
  }

  String titleFormRoutePath(String path) {
    if (path == '/') return 'Home';
    final withoutSlash = path.replaceAll('/', '');
    final firstLetterUpper = withoutSlash[0].toUpperCase();
    final withoutFirstLetter = withoutSlash.substring(1);
    return '$firstLetterUpper$withoutFirstLetter';
  }

  Widget _trasitionBuilder(context, antimation, secondaryAnimation, child) {
    final routerState = GoRouterState.of(context);
    var beginOffsetX = 0;
    var nextRouteIndex = routePaths.indexOf(routerState.path!);
    beginOffsetX = currentRouteIndex < nextRouteIndex ? 1 : -1;

    currentRouteIndex = nextRouteIndex;

    // TODO: Find a way to scroll back to top when trasitioning.
    // scrollController.animateTo(0,
    //     curve: Curves.bounceInOut, duration: Duration(milliseconds: 100));

    // scrollController.jumpTo(1);

    return SlideTransition(
      position: antimation.drive(Tween<Offset>(
        begin: Offset(beginOffsetX.toDouble(), 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.bounceInOut))),
      child: child,
    );
  }

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  late final router =
      GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/', routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return SuperView(child: child);
        },
        routes: routePaths
            .asMap()
            .entries
            .map<GoRoute>((entry) => GoRoute(
                path: routePaths[entry.key],
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                      key: state.pageKey,
                      transitionsBuilder: _trasitionBuilder,
                      child: _getChild(entry.value));
                }))
            .toList())
  ]);
}
