import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';
import 'package:app/features/weather/domain/repository/favorites/favorites.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository favoritesRepository;
  FavoritesBloc(this.favoritesRepository) : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final favorites = favoritesRepository.getCities();

        emit(FavoritesLoaded(favorites: favorites));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });
    on<AddFavorite>((event, emit) async {
      await favoritesRepository.addCity(event.city);
      final favorites = favoritesRepository.getCities();

      emit(FavoritesLoaded(favorites: favorites));
    });

    on<RemoveFavorite>((event, emit) async {
      await favoritesRepository.removeCity(event.cityName);
      final favorites = favoritesRepository.getCities();

      emit(FavoritesLoaded(favorites: favorites));
    });
  }
}
