import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:map_maker_new/services/public_offers_service.dart';

GetIt serviceLocator = GetIt.instance;

void _initializeServices() {
  serviceLocator.registerSingleton<PublicOffersService>(
    PublicOffersService(dio: serviceLocator()),
  );
}

void _initializeClients() {
  serviceLocator.registerLazySingleton(
    () => Dio(),
  );
}

void setupDependencies() {
  _initializeClients();
  _initializeServices();
}
