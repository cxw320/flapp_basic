import 'package:dio/dio.dart';
import 'package:flap_basic/data/network/spoonacular_api.dart';
import 'package:flap_basic/domain/entity/recipe.dart';
import 'package:flap_basic/domain/entity/request_response.dart';
import 'package:flap_basic/domain/repository/recipe/recipe_repository.dart';


class RecipeRepositoryImpl implements RecipeRepository {
  final SpoonacularApi _spoonacularApi;

  RecipeRepositoryImpl({required SpoonacularApi api}) : _spoonacularApi = api;

  @override
  Future<RequestResponse<List<Recipe>, DioException>> getRandomRecipes() async {
    return await _spoonacularApi.getRandomRecipes();
  }
}
