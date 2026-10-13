import 'package:dio/dio.dart';
import 'package:map_maker_new/types/custom_types/offer_search_criteria.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/offer_locations.dart';
import 'package:map_maker_new/types/models/public_offers.dart';

class PublicOffersService {
  static const String _publicOffersUrl = "https://api.plotfinder.xyz/api/offers/public/";
  static const String _locationsUrl = "https://api.plotfinder.xyz/api/offers/public/locations/";

  final Dio dio;

  PublicOffersService({required this.dio});

  Future<PublicOffers> getAllPublicOffers({
    OfferSearchCriteria searchCriteria = const OfferSearchCriteria(),
  }) async {
    try{
      final List<Offer> offers = [];
      String? nextPageUrl = _publicOffersUrl;
      Map<String, dynamic>? queryParameters = searchCriteria.toQueryParameters();
      int count = 0;

      while (nextPageUrl != null) {
        final Response<Map<String, dynamic>> response = await dio.get(
            nextPageUrl, queryParameters: queryParameters);
        final PublicOffers page = PublicOffers.fromJson(response.data!);

        offers.addAll(page.results);
        count = page.count;
        nextPageUrl = page.next;
        queryParameters = null;
      }

      return PublicOffers(
        count: count,
        next: null,
        previous: null,
        results: offers,
      );
    }
    on DioException catch (e) {
      throw Exception("Error ${e.response}");
    }
  }

  Future<OfferLocations> getLocations({String? voivodeship, String? county}) async {
    try{
      final Response<Map<String, dynamic>> response = await dio.get(
        _locationsUrl,
        queryParameters: {
          "voivodeship": ?voivodeship,
          if (voivodeship != null) "county": ?county,
        },
      );
      return OfferLocations.fromJson(response.data!["data"] as Map<String, dynamic>);
    }
    on DioException catch (e) {
      throw Exception("Error ${e.response}");
    }
  }
}
