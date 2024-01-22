import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flap_basic/data/network/dto/recipe_dto.dart';
import 'package:flap_basic/data/network/spoonacular_api.dart';
import 'package:flap_basic/domain/entity/recipe.dart';
import 'package:flap_basic/domain/entity/request_response.dart';
import 'package:flap_basic/util/env/env.dart';

class SpoonacularApiImpl implements SpoonacularApi {
  final Dio dio;
  late final Uri spoonacularUri;

  SpoonacularApiImpl({required this.dio}):
    spoonacularUri = Uri(
      scheme: "https",
      host: "api.spoonacular.com",
      path: "recipes/random",
      queryParameters: {
        "number": "20",
        "apiKey": Env.spoonacularApiKey,
      },
    );

  @override
  Future<RequestResponse<List<Recipe>, DioException>> getRandomRecipes() async {
    try {
      Response response;
      response = await dio.get(spoonacularUri.toString());

      final recipeListResponse = (response.data["recipes"] as List)
          .map((response) => RecipeDto.fromJson(response))
          .toList();
      return Future.value(SuccessRequestResponse(recipeListResponse));
    } on DioException catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        //Uses DioException types to print error message
        log(error.toString());
        return Future.value(ErrorRequestResponse(error));
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Future.value(ErrorRequestResponse(error));
      }
    }
  }
}
