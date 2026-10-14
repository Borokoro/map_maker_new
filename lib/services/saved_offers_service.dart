import 'package:dio/dio.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/public_offers.dart';

class SavedOffersService {
  static const String _apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String _savedOffersUrl = "$_apiBaseUrl/api/offers/saved/";
  static const String _publicOffersUrl = "$_apiBaseUrl/api/offers/public/";

  final Dio dio;

  SavedOffersService({required this.dio});

  Future<PublicOffers> getSavedOffers() async {
    final List<Offer> offers = [];
    String? nextPageUrl = _savedOffersUrl;
    int count = 0;

    while (nextPageUrl != null) {
      final Response<Map<String, dynamic>> response = await dio.get(nextPageUrl);
      final PublicOffers page = PublicOffers.fromJson(response.data!);
      offers.addAll(page.results);
      count = page.count;
      nextPageUrl = page.next;
    }

    return PublicOffers(count: count, next: null, previous: null, results: offers);
  }

  Future<void> saveOffer(String offerId) async {
    await dio.post("$_publicOffersUrl$offerId/save/");
  }

  Future<void> unsaveOffer(String offerId) async {
    await dio.delete("$_publicOffersUrl$offerId/unsave/");
  }
}
