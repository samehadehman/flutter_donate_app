

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/Cities/cities_event.dart';
import 'package:hello/blocs/Cities/cities_state.dart';
import 'package:hello/services/cities_service.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityService service;

  CityBloc({required this.service}) : super(CitiesInitial()) {
    on<FetchCities>(_onFetchCities);
  }

  Future<void> _onFetchCities(FetchCities event, Emitter<CityState> emit) async {
    emit(CitiesLoading());
    try {
      final cities = await service.fetchCities();
      emit(CitiesLoaded(cities));
    } catch (e) {
      emit(CitiesError(e.toString()));
    }
  }
}