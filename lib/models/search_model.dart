class SearchModel {
  final String idMeal;
  final String strMeal;
  final String? strMealAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String strTags;
  final String strYoutube;
  final List<String?> ingredients;
  final List<String?> measures;
  final String? strSource;
  final String? strImageSource;
  final String? strCreativeCommonsConfirmed;
  final String? dateModified;

  SearchModel({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strTags,
    required this.strYoutube,
    required this.ingredients,
    required this.measures,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    List<String?> ingredients = List.generate(20, (index) {
      return json['strIngredient${index + 1}'];
    });

    List<String?> measures = List.generate(20, (index) {
      return json['strMeasure${index + 1}'];
    });

    return SearchModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealAlternate: json['strMealAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'] ?? '',
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
      strSource: json['strSource'],
      strImageSource: json['strImageSource'],
      strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
      dateModified: json['dateModified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealAlternate': strMealAlternate,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      'strSource': strSource,
      'strImageSource': strImageSource,
      'strCreativeCommonsConfirmed': strCreativeCommonsConfirmed,
      'dateModified': dateModified,
    };

    for (int i = 0; i < 20; i++) {
      data['strIngredient${i + 1}'] = ingredients[i];
      data['strMeasure${i + 1}'] = measures[i];
    }

    return data;
  }
}
