import 'package:get_it/get_it.dart';
import 'package:weatherapptask/core/base_app_client.dart';

import 'view_models/auth_view_model.dart';


GetIt di = GetIt.instance;

void setupLocator(String baseAppUr) {

  ///Services injection
  di.registerLazySingleton(() => AuthController());

  ///Base App client
  di.registerFactory(() =>  BaseAppClient(baseAppUr));

}
