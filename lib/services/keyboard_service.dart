import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/services/logging_service.dart';
import 'package:flutterapp/services/route_service.dart';
import 'package:flutterapp/services/theme_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class KeyboardService {
  final _routeService = RouteService();

  final textInputFocusNode = FocusNode(debugLabel: 'Text Input');

  bool keyHandler(
      {required KeyEvent event,
      required BuildContext context,
      required ThemeService themeService}) {
    if (textInputFocusNode.hasFocus || event is! KeyDownEvent) return false;
    bool returnValue = false;
    if (_handelKeyboardRouting(context: context, event: event)) {
      returnValue = true;
    }
    // _handelKeyboardRouting(context: context, event: event);
    if (_handleThemeToggle(event: event, themeService: themeService)) {
      returnValue = true;
    }

    return returnValue;
  }

  bool _handelKeyboardRouting(
      {required KeyEvent event, required BuildContext context}) {
    if (!HardwareKeyboard.instance.physicalKeysPressed
        .contains(PhysicalKeyboardKey.shiftLeft)) return false;

    final currentRouteIndex =
        _routeService.routePaths.indexOf(GoRouter.of(context).location);

    if (event.physicalKey == PhysicalKeyboardKey.keyJ) {
      final leftRouteIndex = currentRouteIndex - 1;

      if (leftRouteIndex > -1) {
        context.go(_routeService.routePaths[leftRouteIndex]);
        return true;
      }
    } else if (event.physicalKey == PhysicalKeyboardKey.keyK) {
      final rightRouteIndex = currentRouteIndex + 1;

      if (rightRouteIndex < _routeService.routePaths.length) {
        context.go(_routeService.routePaths[rightRouteIndex]);
        return true;
      }
    }
    return false;
  }

  bool _handleThemeToggle(
      {required KeyEvent event, required ThemeService themeService}) {
    if (!HardwareKeyboard.instance.physicalKeysPressed
        .contains(PhysicalKeyboardKey.controlLeft)) return false;
    if (event.physicalKey == PhysicalKeyboardKey.keyQ) {
      // final themeService = Provider.of<ThemeService>(context);
      themeService.toggleThemeMode();
      return true;
    }
    return false;
  }
}
