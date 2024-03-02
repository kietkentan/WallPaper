import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpr/state/app_state.dart';
import 'package:wpr/state/theme_state.dart';

import 'config/route.dart';
import 'extension/extensions.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

ThemeState _themeState = ThemeState();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeState.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeState.getMode(context);
    _themeState.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppState>(create: (_) => AppState()),
          ChangeNotifierProvider<ThemeState>(create: (_) => _themeState)
        ],
        child: MaterialApp(
            title: 'WallPaper',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: _themeState.themeMode,
            routes: Routes.route(),
            onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
            onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
            initialRoute: "HomeScreen",
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('vi', ''),
            debugShowCheckedModeBanner: false
        )
    );
  }
}
