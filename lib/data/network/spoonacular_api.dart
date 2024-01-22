import 'package:dio/dio.dart';
import 'package:flap_basic/domain/entity/recipe.dart';
import 'package:flap_basic/domain/entity/request_response.dart';

abstract class SpoonacularApi {
  Future<RequestResponse<List<Recipe>, DioException>> getRandomRecipes();
}