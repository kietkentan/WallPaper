import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wpr/extension/extensions.dart';
import 'package:wpr/state/theme_state.dart';
import 'package:wpr/theme/color/app_color.dart';
import 'package:wpr/view/ui/home_page.dart';

import '../../state/app_state.dart';
import '../widget/bottom_menu_bar.dart';
import '../widget/helper_widget.dart';
import 'categories_page.dart';
import 'favorites_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final themeState = context.watch<ThemeState>();
    TextTheme textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);

    if (appState.favorites == null) {
      appState.getFavorite();
    }
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          if (appState.isSearch) {
            appState.setIsSearch = false;
          } else {
            SystemNavigator.pop();
          }
        },
        child: Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: appState.isSearch
                ? AppBar(
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        onPressed: () {
                          appState.setIsSearch = false;
                        }),
                    backgroundColor: Colors.transparent,
                    title: Row(children: [
                      Expanded(
                          child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search here',
                                border: InputBorder.none,
                              ),
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              onSubmitted: (String value) {

                              }))
                    ]),
                  )
                : AppBar(
                    title: Text(translation(context).title_app),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    actions: [
                        Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: appState.pageIndex == -1
                                ? IconButton(
                                    icon: const Icon(Icons.search),
                                    iconSize: 30.0,
                                    onPressed: () {
                                      appState.setIsSearch = true;
                                    })
                                : null)
                      ]),
            drawer: Drawer(
                backgroundColor: theme.primaryColor,
                child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                  DrawerHeader(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 10),
                      child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: AppColor.bgHeaderDraw,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10))),
                          child: Center(
                              child: Text('Logo',
                                  style: textTheme.headlineSmall)))),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(translation(context).title_mode,
                                    style: textTheme.bodyLarge?.copyWith(
                                        fontFamily: 'OpenSansBold'))),
                            Container(
                                decoration: const BoxDecoration(
                                    color: AppColor.bgHeaderDraw,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(children: [
                                  themeWidget(
                                      textStyle: textTheme.bodyLarge,
                                      checkBoxColor: AppColor.white,
                                      icon: 'assets/ic_sun.png',
                                      text: translation(context).light_mode,
                                      isChecked: themeState.mode == 1,
                                      onClick: () {
                                        themeState.toggleTheme(1, context);
                                      }),
                                  themeWidget(
                                      textStyle: textTheme.bodyLarge,
                                      checkBoxColor: AppColor.white,
                                      icon: 'assets/ic_moon.png',
                                      text: translation(context).dark_mode,
                                      isChecked: themeState.mode == 2,
                                      onClick: () {
                                        themeState.toggleTheme(2, context);
                                      }),
                                  themeWidget(
                                      textStyle: textTheme.bodyLarge,
                                      checkBoxColor: AppColor.white,
                                      icon: 'assets/ic_system_pre.png',
                                      text: translation(context).sys_pre,
                                      isChecked: themeState.mode != 1 &&
                                          themeState.mode != 2,
                                      onClick: () {
                                        themeState.toggleTheme(0, context);
                                      })
                                ])),
                            themeWidget(
                                textStyle: textTheme.bodyLarge,
                                checkBoxColor: theme.secondaryHeaderColor,
                                icon: 'assets/ic_feed_back.png',
                                fit: BoxFit.fitWidth,
                                text: translation(context).feed_back,
                                onClick: () {}),
                            themeWidget(
                                textStyle: textTheme.bodyLarge,
                                checkBoxColor: theme.secondaryHeaderColor,
                                icon: 'assets/ic_privacy.png',
                                text: translation(context).privacy,
                                onClick: () {})
                          ]))
                  // Add more items as needed
                ])),
            body: Column(
                children: [const BottomMenuBar(), Expanded(child: _body())])));
  }

  Widget _body() {
    return SafeArea(
        child: Container(child: _getPage(context.watch<AppState>().pageIndex)));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const CategoriesPage();
      case 2:
        return const FavoritesPage();
    }
    return Container();
  }
}
