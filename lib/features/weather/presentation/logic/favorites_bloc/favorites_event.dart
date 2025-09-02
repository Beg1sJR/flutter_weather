part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent extends Equatable {}

class LoadFavorites extends FavoritesEvent {
  @override
  List<Object?> get props => [];
}

class AddFavorite extends FavoritesEvent {
  final WeatherEntity city;

  AddFavorite(this.city);

  @override
  List<Object?> get props => [city];
}

class RemoveFavorite extends FavoritesEvent {
  final String cityName;

  RemoveFavorite(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
