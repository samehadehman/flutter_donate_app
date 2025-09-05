import 'package:hello/models/cities_model.dart';

abstract class CityState {}
class CitiesInitial extends CityState {}
class CitiesLoading extends CityState {}
class CitiesLoaded extends CityState {
  final List<City> cities;
  CitiesLoaded(this.cities);
}
class CitiesError extends CityState {
  final String message;
  CitiesError(this.message);
}
