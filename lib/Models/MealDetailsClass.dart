class MealDetails {
  final String idMeal;
  final String strMeal;
  final String strDrinkAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String strYoutube;
  final List<String> ingredients;
  final List<String> measures;
  final String strSource;

  MealDetails({
    required this.idMeal,
    required this.strMeal,
    required this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strYoutube,
    required this.ingredients,
    required this.measures,
    required this.strSource,
  });

  factory MealDetails.fromJson(Map<String, dynamic> json) {
    return MealDetails(
      idMeal: json['idMeal'] ?? "",
      strMeal: json['strMeal'] ?? "",
      strDrinkAlternate: json['strDrinkAlternate'] ?? "",
      strCategory: json['strCategory'] ?? "",
      strArea: json['strArea'] ?? "",
      strInstructions: json['strInstructions'] ?? "",
      strMealThumb: json['strMealThumb'] ?? "",
      strYoutube: json['strYoutube'] ?? "",
      ingredients: [
        json['strIngredient1'] ?? "",
        json['strIngredient2'] ?? "",
        json['strIngredient3'] ?? "",
        json['strIngredient4'] ?? "",
        json['strIngredient5'] ?? "",
        json['strIngredient6'] ?? "",
        json['strIngredient7'] ?? "",
        json['strIngredient8'] ?? "",
        json['strIngredient9'] ?? "",
        json['strIngredient10'] ?? "",
        json['strIngredient11'] ?? "",
        json['strIngredient12'] ?? "",
        json['strIngredient13'] ?? "",
        json['strIngredient14'] ?? "",
        json['strIngredient15'] ?? "",
        json['strIngredient16'] ?? "",
        json['strIngredient17'] ?? "",
        json['strIngredient18'] ?? "",
        json['strIngredient19'] ?? "",
        json['strIngredient20'] ?? "",
      ],
      measures: [
        json['strMeasure1'] ?? "",
        json['strMeasure2'] ?? "",
        json['strMeasure3'] ?? "",
        json['strMeasure4'] ?? "",
        json['strMeasure5'] ?? "",
        json['strMeasure6'] ?? "",
        json['strMeasure7'] ?? "",
        json['strMeasure8'] ?? "",
        json['strMeasure9'] ?? "",
        json['strMeasure10'] ?? "",
        json['strMeasure11'] ?? "",
        json['strMeasure12'] ?? "",
        json['strMeasure13'] ?? "",
        json['strMeasure14'] ?? "",
        json['strMeasure15'] ?? "",
        json['strMeasure16'] ?? "",
        json['strMeasure17'] ?? "",
        json['strMeasure18'] ?? "",
        json['strMeasure19'] ?? "",
        json['strMeasure20'] ?? "",
      ],
      strSource: json['strSource'] ?? "",
    );
  }
}
