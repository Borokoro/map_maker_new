import 'dart:convert';
import 'dart:io';

import 'package:map_maker_new/types/models/offer_details.dart';

abstract class OfferDetailsFixture {
  static const String _path = "test/fixtures/offer_details.json";

  static OfferDetails load() {
    final Map<String, dynamic> json = jsonDecode(File(_path).readAsStringSync()) as Map<String, dynamic>;
    return OfferDetails.fromJson(json["data"] as Map<String, dynamic>);
  }
}
