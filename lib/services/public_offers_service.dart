import 'package:dio/dio.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/public_offers.dart';

class PublicOffersService {
  static const String _publicOffersUrl = "https://api.plotfinder.xyz/api/offers/public/";

  final Dio dio;

  PublicOffersService({required this.dio});

  Future<PublicOffers> getAllPublicOffers() async {
    try{
      final List<Offer> offers = [];
      String? nextPageUrl = _publicOffersUrl;
      int count = 0;

      while (nextPageUrl != null) {
        final Response<Map<String, dynamic>> response = await dio.get(
            nextPageUrl);
        final PublicOffers page = PublicOffers.fromJson(response.data!);

        offers.addAll(page.results);
        count = page.count;
        nextPageUrl = page.next;
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
}
