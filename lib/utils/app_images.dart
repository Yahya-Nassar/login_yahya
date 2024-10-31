class ImageApp {
  static String logo = "assets/images/Ultimate.png";
  static String logoHMS = "assets/images/Offers 1@2x.png";
  static String foodChicken = "assets/images/foodChicken.jpg";
  static String foodPasta = "assets/images/foodPasta.jpg";
  static String foodMeat = "assets/images/foodMeat.jpg";
  static String foodFish = "assets/images/foodFish.jpg";
  static String foodChicken1 = "assets/images/foodChicken1.jpg";
}

class CategoryImageProvider {
  static Map<int, String> categoryImages = {
    1: ImageApp.foodFish,
    2: ImageApp.foodPasta,
    3: ImageApp.foodChicken1,
    4: ImageApp.foodMeat,
    5: ImageApp.foodChicken,
  };

  static String getImageForCategory(int categoryIndex) {
    return categoryImages[categoryIndex] ?? ImageApp.foodChicken;
  }
}
