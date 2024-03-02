import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/custom_route.dart';
import '../../state/app_state.dart';
import '../widget/helper_widget.dart';
import 'show_image_screen.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: (MediaQuery.of(context).size.width) / 3,
                    childAspectRatio: 0.7),
                itemCount: (appState.favorites ?? []).length,
                itemBuilder: (BuildContext context, int index) {
                  return tabImage(appState.favorites![index], () {
                    toShowListImage(index, appState.favorites ?? [], appState);
                  });
                })
        )
    );
  }

  Future<void> toShowListImage(int index, List<String> listImage, AppState appState) async {
    if (listImage.isEmpty) return;
    bool? x = await Navigator.push(context, SlideLeftRoute<bool>(
        builder: (BuildContext context) => ShowImageScreen(listImage: listImage, index: index)));
    if (x == true) {
      Future.delayed(const Duration(milliseconds: 300), () {
        appState.notifyListeners();
      });
    }
  }
}
