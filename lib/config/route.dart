import 'package:flutter/material.dart';

import '../view/ui/home_screen.dart';

class Routes {
  static dynamic route() {
    return {
      'HomeScreen': (BuildContext context) => const HomeScreen(),
    };
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      default:
        return onUnknownRoute(const RouteSettings(name: '/HomeScreen'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text(""),
          centerTitle: true
        ),
        body: Center(
          child: Text('${settings.name!.split('/')[1]} Comming soon..')
        )
      )
    );
  }
}