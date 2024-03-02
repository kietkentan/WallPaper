class ItemImage{
  late String img;
  late int codeCategory;

  ItemImage({required this.img, required this.codeCategory});

  static List<ItemImage> get imagesAbstract {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/abstract_$i.jpg', codeCategory: 1));
    }
    return list;
  }

  static List<ItemImage> get imagesAnimal {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/animal_$i.jpg', codeCategory: 2));
    }
    return list;
  }

  static List<ItemImage> get imagesDark {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/dark_$i.jpg', codeCategory: 3));
    }
    return list;
  }

  static List<ItemImage> get imagesCyberpunk {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/cyberpunk_$i.jpg', codeCategory: 4));
    }
    return list;
  }

  static List<ItemImage> get imagesAnime {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/anime_$i.jpg', codeCategory: 5));
    }
    return list;
  }

  static List<ItemImage> get imagesDesert {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/desert_$i.jpg', codeCategory: 6));
    }
    return list;
  }

  static List<ItemImage> get imagesFlower {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/flower_$i.jpg', codeCategory: 7));
    }
    return list;
  }

  static List<ItemImage> get imagesFruit {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/fruit_$i.jpg', codeCategory: 8));
    }
    return list;
  }

  static List<ItemImage> get imagesFunny {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/funny_$i.jpg', codeCategory: 9));
    }
    return list;
  }

  static List<ItemImage> get imagesGem {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/gem_$i.jpg', codeCategory: 10));
    }
    return list;
  }

  static List<ItemImage> get imagesGeometry {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/geometry_$i.jpg', codeCategory: 11));
    }
    return list;
  }

  static List<ItemImage> get imagesLandscape {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/landscape_$i.jpg', codeCategory: 12));
    }
    return list;
  }

  static List<ItemImage> get imagesLove {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/love_$i.jpg', codeCategory: 13));
    }
    return list;
  }

  static List<ItemImage> get imagesNeon {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/neon_$i.jpg', codeCategory: 14));
    }
    return list;
  }

  static List<ItemImage> get imagesSea {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/sea_$i.jpg', codeCategory: 15));
    }
    return list;
  }

  static List<ItemImage> get imagesSky {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/sky_$i.jpg', codeCategory: 16));
    }
    return list;
  }

  static List<ItemImage> get imagesStar {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/star_$i.jpg', codeCategory: 17));
    }
    return list;
  }

  static List<ItemImage> get imagesPeople {
    List<ItemImage> list = [];
    for(int i = 1; i <= 10; i++) {
      list.add(ItemImage(img: 'assets/people_$i.jpg', codeCategory: 18));
    }
    return list;
  }

  static List<ItemImage> get randomImages {
    List<ItemImage> list = [];
    list.addAll(imagesAbstract..shuffle()..sublist(0, 4));
    list.addAll(imagesAnimal..shuffle()..sublist(0, 4));
    list.addAll(imagesDark..shuffle()..sublist(0, 4));
    list.addAll(imagesCyberpunk..shuffle()..sublist(0, 4));
    list.addAll(imagesAnime..shuffle()..sublist(0, 4));
    list.addAll(imagesDesert..shuffle()..sublist(0, 4));
    list.addAll(imagesFlower..shuffle()..sublist(0, 4));
    list.addAll(imagesFruit..shuffle()..sublist(0, 4));
    list.addAll(imagesFunny..shuffle()..sublist(0, 4));
    list.addAll(imagesGem..shuffle()..sublist(0, 4));
    list.addAll(imagesGeometry..shuffle()..sublist(0, 4));
    list.addAll(imagesLandscape..shuffle()..sublist(0, 4));
    list.addAll(imagesLove..shuffle()..sublist(0, 4));
    list.addAll(imagesSea..shuffle()..sublist(0, 4));
    list.addAll(imagesSky..shuffle()..sublist(0, 4));
    list.addAll(imagesStar..shuffle()..sublist(0, 4));
    list.addAll(imagesPeople..shuffle()..sublist(0, 4));
    return list;
  }
}