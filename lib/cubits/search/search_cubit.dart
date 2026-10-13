import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/services/public_offers_service.dart';
import 'package:map_maker_new/types/models/public_offers.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._publicOffersService) : super(SearchInitial());
  final PublicOffersService _publicOffersService;

  Future<void> fetchPublicOffers() async {
    emit(SearchLoading());
    try{
      final PublicOffers publicOffers = await _publicOffersService
          .getAllPublicOffers();
      emit(SearchLoaded(publicOffers: publicOffers));
    }
    on DioException catch(e) {
      emit(SearchError(exception: e));
    }
    catch(_) {
      emit(SearchError());
    }
  }
}
