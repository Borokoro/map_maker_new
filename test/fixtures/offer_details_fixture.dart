import 'dart:convert';
import 'dart:io';

import 'package:map_maker_new/types/models/offer_details.dart';

abstract class OfferDetailsFixture {
  static const String _path = "test/fixtures/offer_details.json";

  static const String _centerPointKey = "center_point";

  static OfferDetails load() {
    return OfferDetails.fromJson(_readData());
  }

  static OfferDetails loadWithoutMap() {
    final Map<String, dynamic> data = _readData();
    data.remove(_centerPointKey);
    return OfferDetails.fromJson(data);
  }

  static Map<String, dynamic> _readData() {
    final Map<String, dynamic> json = jsonDecode(File(_path).readAsStringSync()) as Map<String, dynamic>;
    return json["data"] as Map<String, dynamic>;
  }
}
