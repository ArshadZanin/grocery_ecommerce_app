

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shop_grocery_app/core/services/http_service.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {

  static Future<void> setupLocator() async {
    debugPrint('Initializing transaction service');
    locator.registerLazySingleton(() => HTTPService());
    
  }
}
