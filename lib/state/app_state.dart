import 'package:flutter/material.dart';

import '../extension/extensions.dart';
import '../extension/shared_preference_helper.dart';

class AppState extends ChangeNotifier {
  int _pageIndex = 0;
  get pageIndex => _pageIndex;
  set setPageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  bool _isSearch = false;
  get isSearch => _isSearch;
  set setIsSearch(bool s) {
    _isSearch = s;
    notifyListeners();
  }

  List<String>? favorites;

  bool checkFavorite(String uri) {
    return favorites != null && favorites!.contains(uri);
  }

  bool addImageToFavorite(String uri) {
    favorites ??= [];
    bool contain = false;
    if (favorites!.contains(uri)) {
      favorites!.removeWhere((element) => element == uri);
      contain = true;
    } else {
      favorites!.add(uri);
      notifyListeners();
    }
    saveFavorites();
    return contain;
  }

  getFavorite() async {
    favorites = await getIt<SharedPreferenceHelper>()
        .getImageFavorite()
        .then((value) => value);
    notifyListeners();
  }

  void saveFavorites() {
    try {
      getIt<SharedPreferenceHelper>().setImageFavorite(favorites ?? []);
    } catch (error) {
      print('ErrorInAppState: $error');
    }
  }
}