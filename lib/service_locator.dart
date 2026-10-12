
import 'package:get_it/get_it.dart';
import 'package:map_maker_new/services/public_offers_service.dart';

GetIt serviceLocator = GetIt.instance;

void _initializeServices() {
  serviceLocator.registerSingleton<PublicOffersService>(PublicOffersService(dio: serviceLocator()));
}

void setupDependencies() {
  _initializeServices();
}