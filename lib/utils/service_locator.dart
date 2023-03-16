import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/*
 This function will initialise all the below Classes
 and creates a singleton so we don't have to create new instances
 again and again.
 */

Future<void> setupLocator() async {
  getIt.allowReassignment = true;

  Dio dio = Dio();

  // Setting up get it instance for DIO
  getIt.registerLazySingleton<Dio>(() => dio);


}

