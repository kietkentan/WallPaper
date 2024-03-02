import 'package:flutter/material.dart';

import '../../config/custom_route.dart';
import '../../model/item_image.dart';
import '../widget/helper_widget.dart';
import 'show_image_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemImage> list = ItemImage.randomImages;

  @override
  Widget build(BuildContext context) {
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
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return tabImage(list[index].img, () {
                  toShowListImage(index);
                });
              })
        )
    );
  }

  void toShowListImage(int index) {
    Navigator.push(context, SlideLeftRoute<bool>(
        builder: (BuildContext context) => ShowImageScreen(listImage: list.map((e) => e.img).toList(), index: index)));
  }
}
