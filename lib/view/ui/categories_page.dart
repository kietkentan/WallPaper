import 'package:flutter/material.dart';
import 'package:wpr/model/category.dart';
import 'package:wpr/theme/color/app_color.dart';

import '../../config/custom_route.dart';
import '../widget/helper_widget.dart';
import 'show_image_screen.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: (MediaQuery.of(context).size.width) / 3,
                    childAspectRatio: 0.823077),
                itemCount: Category.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return tabImageCategory(
                    Category.categories[index],
                    textStyle: textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Inter',
                      color: AppColor.white
                    ),
                    onClick: () {
                      toShowListImage(Category.categories[index].code);
                    }
                  );
                })
        )
    );
  }

  void toShowListImage(int codeCategory) {
    Navigator.push(context, SlideLeftRoute<bool>(
        builder: (BuildContext context) => ShowImageScreen(listImage: Category.getListByCode(codeCategory).map((e) => e.img).toList(), index: 0)));
  }
}
