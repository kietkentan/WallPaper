import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:provider/provider.dart';
import 'package:wpr/theme/color/app_color.dart';

import '../../extension/extensions.dart';
import '../../state/app_state.dart';
import '../widget/helper_widget.dart';

class ShowImageScreen extends StatefulWidget {
  List<String> listImage;
  int index;

  ShowImageScreen({required this.listImage, required this.index, super.key});

  @override
  _ShowImageScreenState createState() => _ShowImageScreenState(index: index);
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  late PageController _pageController;
  int index;

  _ShowImageScreenState({required this.index}) {
    _pageController = PageController(initialPage: index, viewportFraction: 0.7);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () => {
      setState(() {

      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double heightImg = MediaQuery.of(context).size.height - 200;
    final double width = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    final appState = context.watch<AppState>();

    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          Navigator.pop(context, true);
        },
        child: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 30.0,
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            backgroundColor: Colors.transparent
        ),
        body: Column(
            children: [
              SizedBox(
                  height: heightImg,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.listImage.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildImage(index, widget.listImage[index], _pageController);
                      },
                      onPageChanged: (page) {
                        setState(() {
                          index = page;
                        });
                      }
                  )
              ),
              Container(
                  padding:  EdgeInsets.symmetric(vertical: 20, horizontal: width * 0.13),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.share, color: theme.secondaryHeaderColor),
                            iconSize: 30.0,
                            padding: const EdgeInsets.all(10),
                            onPressed: () {
                              shareImage(widget.listImage[index]);
                            }),
                        ClipOval(
                            child: Container(
                                color: AppColor.bgHeaderDraw,
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () async {
                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor: theme.primaryColor,
                                            builder: (BuildContext context) {
                                              return MyBottomSheetContent(img: widget.listImage[index], theme: theme, textTheme: textTheme);
                                            },
                                          );
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(20),
                                            child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Image.asset('assets/ic_download.png', color: AppColor.white, fit: BoxFit.fitHeight)
                                            )
                                        )
                                    )
                                )
                            )
                        ),
                        IconButton(
                            icon: SizedBox(
                                height: 30,
                                child: Image.asset(appState.checkFavorite(widget.listImage[index]) ? 'assets/ic_heart.png' : 'assets/ic_heart_un.png', color: appState.checkFavorite(widget.listImage[index]) ? AppColor.bgHeaderDraw : theme.secondaryHeaderColor, fit: BoxFit.fitHeight)
                            ),
                            iconSize: 30.0,
                            padding: const EdgeInsets.all(10),
                            onPressed: () {
                              bool contain = appState.addImageToFavorite(widget.listImage[index]);
                              if (contain) {
                                if ((appState.favorites ?? []).isNotEmpty) {
                                  setState(() {
                                    if (index > 0) {
                                      index -= 1;
                                    }
                                  });
                                  _pageController.jumpToPage(index);
                                } else {
                                  Navigator.pop(context, true);
                                }
                              }
                            })
                      ]
                  )
              )
            ]
        )
    ));
  }
}

class MyBottomSheetContent extends StatelessWidget {
  String img;
  ThemeData theme;
  TextTheme textTheme;

  MyBottomSheetContent({required this.img, required this.theme, required this.textTheme, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 4,
            width: 150,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: theme.secondaryHeaderColor,
              borderRadius: const BorderRadius.all(Radius.circular(2))
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Text(translation(context).what_wyl,
                  style: textTheme.bodyLarge
                      ?.copyWith(fontFamily: 'OpenSansBold'))
            ),
          ),
          themeWidget(
              textStyle: textTheme.bodyLarge,
              checkBoxColor: theme.secondaryHeaderColor,
              icon: 'assets/ic_image.png',
              text: translation(context).set_wallpaper,
              onClick: () {
                setWallPaper(context, WallpaperManager.HOME_SCREEN);
              }
          ),
          themeWidget(
              textStyle: textTheme.bodyLarge,
              checkBoxColor: theme.secondaryHeaderColor,
              icon: 'assets/ic_block.png',
              text: translation(context).set_lock_screen,
              onClick: () {
                setWallPaper(context, WallpaperManager.LOCK_SCREEN);
              }
          ),
          themeWidget(
              textStyle: textTheme.bodyLarge,
              checkBoxColor: theme.secondaryHeaderColor,
              icon: 'assets/ic_image_block.png',
              text: translation(context).set_both,
              onClick: () {
                setWallPaper(context, WallpaperManager.BOTH_SCREEN);
              }
          ),
          themeWidget(
              textStyle: textTheme.bodyLarge,
              checkBoxColor: theme.secondaryHeaderColor,
              icon: 'assets/ic_download.png',
              text: translation(context).save_to_media_folder,
              onClick: () {
                Navigator.of(context).pop();
                saveImageToDisk(theme.brightness == Brightness.light, img, translation(context).saved, translation(context).save_failed);
              }
          )
        ]
      )
    );
  }

  void setWallPaper(BuildContext context, int location) {
    Navigator.of(context).pop();
    setWallpaper(img, location, theme.brightness == Brightness.light, translation(context).set_wall_done, translation(context).set_failed);
  }
}
