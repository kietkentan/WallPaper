import 'package:flutter/material.dart';

import '../extension/extensions.dart';
import '../extension/shared_preference_helper.dart';

class ThemeState with ChangeNotifier{
  int mode = 1;

  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;

  toggleTheme(int m, BuildContext context) {
    mode = m;
    bool isDark = m == 2;
    if (m == 0) {
      Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
      isDark = platformBrightness == Brightness.dark;
    }
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    saveMode();
    notifyListeners();
  }

  getMode(BuildContext context) async {
    mode = await getIt<SharedPreferenceHelper>()
        .getMode()
        .then((value) => value);
    toggleTheme(mode, context);
    notifyListeners();
  }

  void saveMode() {
    try {
      getIt<SharedPreferenceHelper>().setMode(mode);
    } catch (error) {
      print('ErrorInNumberState: $error');
    }
  }
}