import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/cubits/saved_offers/saved_offers_cubit.dart';
import 'package:map_maker_new/cubits/search/search_cubit.dart';
import 'package:map_maker_new/services/auth_interceptor.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/services/public_offers_service.dart';
import 'package:map_maker_new/services/saved_offers_service.dart';
import 'package:map_maker_new/services/token_storage.dart';

GetIt serviceLocator = GetIt.instance;

void _initializeServices() {
  serviceLocator.registerSingleton<TokenStorage>(TokenStorage());
  serviceLocator.registerSingleton<AuthService>(
    AuthService(dio: serviceLocator(), tokenStorage: serviceLocator()),
  );
  serviceLocator.registerSingleton<PublicOffersService>(
    PublicOffersService(dio: serviceLocator()),
  );
  serviceLocator.registerSingleton<SavedOffersService>(
    SavedOffersService(dio: serviceLocator()),
  );
}

void _initializeCubits() {
  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SavedOffersCubit>(
    () => SavedOffersCubit(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SearchCubit>(
    () => SearchCubit(serviceLocator(), serviceLocator()),
  );
}

void _initializeClients() {
  serviceLocator.registerLazySingleton<Dio>(_createDio);
}

Dio _createDio() {
  final Dio dio = Dio();
  dio.interceptors.add(AuthInterceptor(dio));
  return dio;
}

void setupDependencies() {
  _initializeClients();
  _initializeServices();
  _initializeCubits();
}
