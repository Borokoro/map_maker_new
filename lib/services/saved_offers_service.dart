import 'package:dio/dio.dart';
import 'package:map_maker_new/constants/env_constants.dart';
import 'package:map_maker_new/services/pagination/paginated_response.dart';
import 'package:map_maker_new/types/models/offer.dart';
import 'package:map_maker_new/types/models/public_offers.dart';

class SavedOffersService {
  static const String _savedOffersUrl = "${EnvConstants.apiBaseUrl}/api/offers/saved/";
  static const String _publicOffersUrl = "${EnvConstants.apiBaseUrl}/api/offers/public/";

  static const int pageSize = 10;

  final Dio dio;

  SavedOffersService({required this.dio});

  Future<PaginatedResponse<Offer>> getSavedOffers({required int page}) async {
    final Response<Map<String, dynamic>> response = await dio.get(
      _savedOffersUrl,
      queryParameters: {"page": page, "page_size": pageSize},
    );
    final PublicOffers savedOffers = PublicOffers.fromJson(response.data!);
    return PaginatedResponse<Offer>(
      data: savedOffers.results,
      nextPage: PaginatedResponse.getPageFromUrl(savedOffers.next),
      itemsCount: savedOffers.count,
    );
  }

  Future<void> saveOffer(String offerId) async {
    await dio.post("$_publicOffersUrl$offerId/save/");
  }

  Future<void> unsaveOffer(String offerId) async {
    await dio.delete("$_publicOffersUrl$offerId/unsave/");
  }
}
