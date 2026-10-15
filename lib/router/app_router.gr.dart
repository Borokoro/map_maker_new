// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:map_maker_new/types/enum/offer_view_source.dart' as _i12;
import 'package:map_maker_new/view/pages/account/account_page.dart' as _i1;
import 'package:map_maker_new/view/pages/auth/signup/signup_page.dart' as _i8;
import 'package:map_maker_new/view/pages/landing/landing_page.dart' as _i2;
import 'package:map_maker_new/view/pages/messages/messages_page.dart' as _i3;
import 'package:map_maker_new/view/pages/offer/offer_page.dart' as _i4;
import 'package:map_maker_new/view/pages/saved/saved_pages.dart' as _i5;
import 'package:map_maker_new/view/pages/search/search_page.dart' as _i6;
import 'package:map_maker_new/view/pages/sell/sell_page.dart' as _i7;
import 'package:map_maker_new/view/pages/web_view/web_view_page.dart' as _i9;

/// generated route for
/// [_i1.AccountPage]
class AccountRoute extends _i10.PageRouteInfo<void> {
  const AccountRoute({List<_i10.PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountPage();
    },
  );
}

/// generated route for
/// [_i2.LandingPage]
class LandingRoute extends _i10.PageRouteInfo<void> {
  const LandingRoute({List<_i10.PageRouteInfo>? children})
    : super(LandingRoute.name, initialChildren: children);

  static const String name = 'LandingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.LandingPage();
    },
  );
}

/// generated route for
/// [_i3.MessagesPage]
class MessagesRoute extends _i10.PageRouteInfo<void> {
  const MessagesRoute({List<_i10.PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.MessagesPage();
    },
  );
}

/// generated route for
/// [_i4.OfferPage]
class OfferRoute extends _i10.PageRouteInfo<OfferRouteArgs> {
  OfferRoute({
    _i11.Key? key,
    required String offerId,
    _i12.OfferViewSource viewSource = _i12.OfferViewSource.link,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         OfferRoute.name,
         args: OfferRouteArgs(
           key: key,
           offerId: offerId,
           viewSource: viewSource,
         ),
         rawPathParams: {'offerId': offerId},
         initialChildren: children,
       );

  static const String name = 'OfferRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<OfferRouteArgs>(
        orElse: () => OfferRouteArgs(offerId: pathParams.getString('offerId')),
      );
      return _i4.OfferPage(
        key: args.key,
        offerId: args.offerId,
        viewSource: args.viewSource,
      );
    },
  );
}

class OfferRouteArgs {
  const OfferRouteArgs({
    this.key,
    required this.offerId,
    this.viewSource = _i12.OfferViewSource.link,
  });

  final _i11.Key? key;

  final String offerId;

  final _i12.OfferViewSource viewSource;

  @override
  String toString() {
    return 'OfferRouteArgs{key: $key, offerId: $offerId, viewSource: $viewSource}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OfferRouteArgs) return false;
    return key == other.key &&
        offerId == other.offerId &&
        viewSource == other.viewSource;
  }

  @override
  int get hashCode => key.hashCode ^ offerId.hashCode ^ viewSource.hashCode;
}

/// generated route for
/// [_i5.SavedPages]
class SavedRoute extends _i10.PageRouteInfo<void> {
  const SavedRoute({List<_i10.PageRouteInfo>? children})
    : super(SavedRoute.name, initialChildren: children);

  static const String name = 'SavedRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.SavedPages();
    },
  );
}

/// generated route for
/// [_i6.SearchPage]
class SearchRoute extends _i10.PageRouteInfo<void> {
  const SearchRoute({List<_i10.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.SearchPage();
    },
  );
}

/// generated route for
/// [_i7.SellPage]
class SellRoute extends _i10.PageRouteInfo<void> {
  const SellRoute({List<_i10.PageRouteInfo>? children})
    : super(SellRoute.name, initialChildren: children);

  static const String name = 'SellRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.SellPage();
    },
  );
}

/// generated route for
/// [_i8.SignupPage]
class SignupRoute extends _i10.PageRouteInfo<void> {
  const SignupRoute({List<_i10.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignupPage();
    },
  );
}

/// generated route for
/// [_i9.WebViewPage]
class WebViewRoute extends _i10.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i11.Key? key,
    required String title,
    required String url,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         WebViewRoute.name,
         args: WebViewRouteArgs(key: key, title: title, url: url),
         initialChildren: children,
       );

  static const String name = 'WebViewRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return _i9.WebViewPage(key: args.key, title: args.title, url: args.url);
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({this.key, required this.title, required this.url});

  final _i11.Key? key;

  final String title;

  final String url;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, title: $title, url: $url}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WebViewRouteArgs) return false;
    return key == other.key && title == other.title && url == other.url;
  }

  @override
  int get hashCode => key.hashCode ^ title.hashCode ^ url.hashCode;
}
