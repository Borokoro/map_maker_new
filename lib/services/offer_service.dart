import 'package:dio/dio.dart';
import 'package:map_maker_new/constants/env_constants.dart';
import 'package:map_maker_new/types/enum/offer_view_source.dart';
import 'package:map_maker_new/types/models/offer_contact.dart';
import 'package:map_maker_new/types/models/offer_details.dart';

class OfferService {
  static const String _publicOffersUrl = "${EnvConstants.apiBaseUrl}/api/offers/public/";

  final Dio dio;

  OfferService({required this.dio});

  Future<OfferDetails> getOffer(String offerId) async {
    final Response<Map<String, dynamic>> response = await dio.get("$_publicOffersUrl$offerId/");
    return OfferDetails.fromJson(response.data!["data"] as Map<String, dynamic>);
  }

  Future<void> registerView(String offerId, OfferViewSource source) async {
    await dio.post("$_publicOffersUrl$offerId/views/create/", data: {"source": source.apiValue});
  }

  Future<OfferContact> revealContact(String offerId) async {
    final Response<Map<String, dynamic>> response = await dio.post("$_publicOffersUrl$offerId/contact/");
    return OfferContact.fromJson(response.data!["data"] as Map<String, dynamic>);
  }
}
