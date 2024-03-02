import 'package:flutter/material.dart';
import 'package:wpr/model/category.dart';

Widget themeWidget(
    {TextStyle? textStyle,
    required Color checkBoxColor,
    required String icon,
    required String text,
    bool? isChecked,
    BoxFit? fit,
    required Function onClick}) {
  return Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: () => onClick.call(),
          child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(children: [
                Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(icon,
                        fit: fit ?? BoxFit.fitHeight, color: checkBoxColor)),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(text,
                        style: textStyle?.copyWith(
                            color: checkBoxColor, fontFamily: 'Inter'))),
                isChecked != null
                    ? Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: checkBoxColor, width: 2)),
                        child: Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isChecked == true
                                    ? checkBoxColor
                                    : Colors.transparent)))
                    : const SizedBox()
              ]))));
}

Widget customIcon(BuildContext context,
    {required IconData icon,
    bool isEnable = false,
    double size = 30,
    bool isFontAwesomeSolid = false,
    Color? iconColor,
    double paddingIcon = 0}) {
  iconColor = iconColor ?? Theme.of(context).textTheme.bodySmall!.color;
  return Padding(
      padding: EdgeInsets.only(bottom: paddingIcon),
      child: Icon(icon, size: size, color: iconColor));
}

Widget tabImage(String img, Function onClick) {
  return InkWell(
      onTap: () {
        onClick.call();
      },
      child: Container(
          padding: const EdgeInsets.all(1.5),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.asset(img, fit: BoxFit.cover))));
}

Widget tabImageCategory(Category category,
    {TextStyle? textStyle, Function? onClick}) {
  return InkWell(
      onTap: () {
        onClick?.call();
      },
      child: Container(
          padding: const EdgeInsets.all(1.5),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(category.thumb),
                          fit: BoxFit.fitHeight)),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                          height: 40,
                          child: Stack(children: [
                            Opacity(
                                opacity: 0.2,
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black))),
                            Center(
                                child: Text(category.name,
                                    style: textStyle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis))
                          ])))))));
}

Widget buildImage(int index, String img, PageController pageController) {
  return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? child) {
        double scale = 1.0;
        if (pageController.position.haveDimensions) {
          final double normalizedValue =
              (pageController.page! - index).abs().clamp(0.0, 1.0);
          scale = 1.0 - normalizedValue * 0.1;
        }
        return Transform.scale(
            scale: scale,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(img, fit: BoxFit.cover)));
      });
}
