 import 'package:flutter/material.dart';

import 'log_util.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    logSuccess('Navigating to: $routeName with arguments: $arguments');
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    logSuccess('Replacing with: $routeName with arguments: $arguments');
    return Navigator.of(this).pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments}) {
    logSuccess(
        'Navigating to (and removing all previous): $routeName with arguments: $arguments');
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }

  void pop() {
    logSuccess('Popping current route');
    Navigator.of(this).pop();
  }
}
