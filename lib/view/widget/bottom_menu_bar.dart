import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../extension/extensions.dart';
import '../../state/app_state.dart';
import '../../theme/color/app_color.dart';
import 'helper_widget.dart';

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({super.key});

  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  @override
  void initState() {
    super.initState();
  }

  Widget _iconRow() {
    return Container(
        height: 60,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Expanded(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                _icon(null, translation(context).home, 0,
                    icon: Icons.home, isCustomIcon: true),
                _icon(null, translation(context).categories, 1,
                    icon: Icons.category_outlined, isCustomIcon: true),
                _icon('assets/ic_heart.png', translation(context).favorite, 2,
                    icon: null, isCustomIcon: false)
              ])),
          Container(
              height: 1,
              width: double.infinity,
              color: AppColor.navUnSelect)
        ]));
  }

  Widget _icon(String? iconImage, String? text, int index,
      {bool isCustomIcon = false, IconData? icon}) {
    if (isCustomIcon) {
      assert(icon != null);
    } else {
      assert(iconImage != null);
    }
    var state = context.watch<AppState>();
    return Expanded(
        child: InkWell(
            onTap: () {
              state.setPageIndex = index;
            },
            child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        isCustomIcon
                            ? customIcon(context,
                                icon: icon!,
                                size: 30,
                                iconColor: index == state.pageIndex
                                    ? AppColor.bgHeaderDraw
                                    : Theme.of(context).unselectedWidgetColor,
                                isEnable: index == state.pageIndex)
                            : Image.asset(iconImage!,
                                height: 30,
                                color: index == state.pageIndex
                                    ? AppColor.bgHeaderDraw
                                    : Theme.of(context).unselectedWidgetColor),
                        state.pageIndex == index
                            ? Text(text ?? '',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: index == state.pageIndex
                                        ? AppColor.bgHeaderDraw
                                        : Theme.of(context).unselectedWidgetColor,
                                    fontFamily: 'OpenSans',
                                    decoration: TextDecoration.none),
                                maxLines: 1)
                            : const SizedBox()
                      ])),
                  Container(
                      height: 4,
                      width: 90,
                      decoration: BoxDecoration(
                          color: state.pageIndex == index
                              ? AppColor.bgHeaderDraw
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2))))
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return _iconRow();
  }
}
