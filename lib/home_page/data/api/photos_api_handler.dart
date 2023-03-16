import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:otto_international_assign/home_page/data/models/Image_model.dart';
import 'package:otto_international_assign/utils/api_routes.dart';

class ImageApiHandler{

  static Dio dio = GetIt.I<Dio>();

  static Future<List<ImageModel>> getListOfImages(int pageNumber) async {
    try{
      Map<String, dynamic> query = {
        "page": pageNumber,
        "client_id": "3Ni6CE4RjUnZUCfN1I0lzO-knkoAMnAcashkWpfROb0"
      };

      Response response = await dio.get(
        APIRoutes.getListOfPhotosUrl,
        queryParameters: query,
      );

      print("${response.headers}");

      List<dynamic> responseList = response.data;
      List<ImageModel> listOfImages = responseList.map((e) => ImageModel.fromJson(e)).toList();

      return listOfImages;
    }
    catch(E, stacktrace){
      log("$stacktrace");
      throw Exception("Error Occurred $E");
    }
  }
}