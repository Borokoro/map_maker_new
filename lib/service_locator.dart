import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/services/public_offers_service.dart';

GetIt serviceLocator = GetIt.instance;

void _initializeServices() {
  serviceLocator.registerSingleton<PublicOffersService>(
    PublicOffersService(dio: serviceLocator()),
  );
}

void _initializeCubits() {
  serviceLocator.registerLazySingleton<SearchCubit>(
    () => SearchCubit(serviceLocator()),
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
  _initializeCubits();
}
