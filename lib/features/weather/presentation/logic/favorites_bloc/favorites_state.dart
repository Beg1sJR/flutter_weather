part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState extends Equatable {}

final class FavoritesInitial extends FavoritesState {
  @override
  List<Object?> get props => [];
}

final class FavoritesLoading extends FavoritesState {
  @override
  List<Object?> get props => [];
}

final class FavoritesLoaded extends FavoritesState {
  final List<WeatherEntity> favorites;

  FavoritesLoaded({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

final class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}
