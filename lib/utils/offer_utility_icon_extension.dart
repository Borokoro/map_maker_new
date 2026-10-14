import 'package:flutter/material.dart';
import 'package:map_maker_new/constants/icon_constants.dart';
import 'package:map_maker_new/types/enum/offer_utility.dart';

extension OfferUtilityIconExtension on OfferUtility {
  IconData get icon {
    switch (this) {
      case OfferUtility.electricity:
        return IconConstants.electricity;
      case OfferUtility.water:
        return IconConstants.water;
      case OfferUtility.sewage:
        return IconConstants.sewage;
      case OfferUtility.gas:
        return IconConstants.gas;
      case OfferUtility.internet:
        return IconConstants.internet;
    }
  }
}
