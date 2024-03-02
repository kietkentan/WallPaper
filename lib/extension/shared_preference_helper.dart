import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper._internal();
  static final SharedPreferenceHelper _singleton =
  SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() {
    return _singleton;
  }

  Future clearPreferenceValues() async {
    (await SharedPreferences.getInstance()).clear();
  }

  Future<bool> setMode(int coin) async {
    return (await SharedPreferences.getInstance()).setInt(
        WallPreferenceKey.MODE.name, coin);
  }

  Future<int> getMode() async {
    int? num = (await SharedPreferences.getInstance())
        .getInt(WallPreferenceKey.MODE.name);
    return num ?? 1;
  }

  Future<bool> setImageFavorite(List<String> list) async {
    return (await SharedPreferences.getInstance()).setStringList(
        WallPreferenceKey.FAVORITE.name, list);
  }

  Future<List<String>> getImageFavorite() async {
    List<String>? list = (await SharedPreferences.getInstance())
        .getStringList(WallPreferenceKey.FAVORITE.name);
    return list ?? [];
  }
}

enum WallPreferenceKey { MODE, FAVORITE }