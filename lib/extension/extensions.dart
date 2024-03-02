import 'dart:io';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/color/app_color.dart';
import 'shared_preference_helper.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}

void showToast(String msg, bool isLight) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: isLight ? AppColor.white : AppColor.black,
    textColor: isLight ? Colors.black : AppColor.white,
  );
}

Future<bool> checkAndRequestStoragePermission() async {
  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  AndroidDeviceInfo android = await plugin.androidInfo;
  bool accept = false;
  PermissionStatus status = android.version.sdkInt < 33
      ? await Permission.storage.status
      : await Permission.photos.status;
  if (status.isGranted) {
    accept = true;
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  } else {
    status = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : await Permission.photos.request();
    if (status.isGranted) {
      accept = true;
    }
  }
  return accept;
}

void saveImageToDisk(bool isLight, String uri, String textDone, String textNot) async {
  bool done = false;
  try {
    List<String> sp = uri.split('/');
    if (sp.length > 1) {
      List<String> comma = sp[1].split('.');
      if (comma.length > 1) {
        final ByteData data = await rootBundle.load(uri);

        Directory directory = Directory.systemTemp;

        final String appDocPath = directory.path;
        String fileName = sp[1];
        String filePath = '$appDocPath/$fileName';

        int suffix = 1;
        while (File(filePath).existsSync()) {
          fileName = '${comma[0]}_${suffix++}.${comma[1]}';
          filePath = '$appDocPath/$fileName';
        }

        final file = await File(filePath).create();
        await file.writeAsBytes(
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
        await Gal.putImage(file.path, album: 'WallPaper');

        done = true;
      }
    }
  } catch (e) {
    print('Error saving image: $e');
  }
  String text = done ? textDone : textNot;
  showToast(text, isLight);
}

void shareImage(String uri) async {
  List<String> sp = uri.split('/');
  if (sp.length < 2) return;
  ByteData data = await rootBundle.load(uri);
  Uint8List bytes = data.buffer.asUint8List();

  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/${sp[1]}');
  await file.writeAsBytes(bytes);

  Share.shareFiles(
    [file.path],
    text: 'Check out this image!',
  );
}

void setWallpaper(String uri, int location, bool isLight, String textDone, String textNot) async {
  bool result = false;
  List<String> sp = uri.split('/');
  if (sp.length < 2) {
    result = false;
  }

  try {
    ByteData data = await rootBundle.load(uri);
    Uint8List bytes = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${sp[1]}');
    await file.writeAsBytes(bytes);
    result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  } on PlatformException {
    print('Error set wallpaper');
  }
  String text = result ? textDone : textNot;
  showToast(text, isLight);
}
