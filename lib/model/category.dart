import 'item_image.dart';

class Category {
  String thumb;
  String name;
  int code;

  Category({required this.thumb, required this.name, required this.code});

  static final List<Category> categories = [
    Category(thumb: 'assets/img_abstract.png', name: 'Abstract', code: 1),
    Category(thumb: 'assets/img_animal.png', name: 'Animal', code: 2),
    Category(thumb: 'assets/img_dark.png', name: 'Dark', code: 3),
    Category(thumb: 'assets/img_cyberpunk.png', name: 'Cyberpunk', code: 4),
    Category(thumb: 'assets/img_anime.png', name: 'Anime', code: 5),
    Category(thumb: 'assets/img_desert.png', name: 'Desert', code: 6),
    Category(thumb: 'assets/img_flower.png', name: 'Flower', code: 7),
    Category(thumb: 'assets/img_fruit.png', name: 'Fruit', code: 8),
    Category(thumb: 'assets/img_funny.png', name: 'Funny', code: 9),
    Category(thumb: 'assets/img_gem.png', name: 'Gem', code: 10),
    Category(thumb: 'assets/img_geometry.png', name: 'Geometry', code: 11),
    Category(thumb: 'assets/img_landscape.png', name: 'Landscape', code: 12),
    Category(thumb: 'assets/img_love.png', name: 'Love', code: 13),
    Category(thumb: 'assets/img_neon.png', name: 'Neon', code: 14),
    Category(thumb: 'assets/img_sea.png', name: 'Sea', code: 15),
    Category(thumb: 'assets/img_sky.png', name: 'Sky', code: 16),
    Category(thumb: 'assets/img_star.png', name: 'Star', code: 17),
    Category(thumb: 'assets/img_people.png', name: 'Live Wallpaper', code: 18)
  ];

  static List<ItemImage> getListByCode(int code) {
    switch (code) {
      case 1:
        return ItemImage.imagesAbstract;
      case 2:
        return ItemImage.imagesAnimal;
      case 3:
        return ItemImage.imagesDark;
      case 4:
        return ItemImage.imagesCyberpunk;
      case 5:
        return ItemImage.imagesAnime;
      case 6:
        return ItemImage.imagesDesert;
      case 7:
        return ItemImage.imagesFlower;
      case 8:
        return ItemImage.imagesFruit;
      case 9:
        return ItemImage.imagesFunny;
      case 10:
        return ItemImage.imagesGem;
      case 11:
        return ItemImage.imagesGeometry;
      case 12:
        return ItemImage.imagesLandscape;
      case 13:
        return ItemImage.imagesLove;
      case 14:
        return ItemImage.imagesNeon;
      case 15:
        return ItemImage.imagesSea;
      case 16:
        return ItemImage.imagesSky;
      case 17:
        return ItemImage.imagesStar;
      case 18:
        return ItemImage.imagesPeople;
    }
    return ItemImage.imagesAbstract;
  }
}