// features/search/presentation/pages/search_page.dart
import 'dart:async';
import 'dart:developer';

import 'package:app/core/theme/theme.dart';
import 'package:app/features/weather/data/data_source/weather/weather.dart';
import 'package:app/features/weather/domain/repository/forecast/forecast.dart';
import 'package:app/features/weather/domain/repository/weather/weather.dart';
import 'package:app/features/weather/presentation/logic/details_bloc/weather_details_bloc.dart';
import 'package:app/features/weather/presentation/logic/forecast_bloc/forecast_bloc.dart';
import 'package:app/features/weather/presentation/pages/weather_details_page.dart';
import 'package:app/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _suggestions = [];
  bool _isLoading = false;
  final _debouncer = _Debouncer(milliseconds: 500);
  final dataSource = di.getIt<WeatherData>();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final query = _searchController.text;
    _debouncer.run(() async {
      if (query.length < 2) {
        setState(() => _suggestions = []);
        return;
      }

      setState(() => _isLoading = true);
      try {
        final newSuggestions = await dataSource.getCitySuggestions(query);
        setState(() {
          _suggestions = newSuggestions;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _suggestions = [];
          _isLoading = false;
        });
      }
    });
  }

  void _onCitySelected(String city) async {
    log('Добавлена кнопка');
    FocusScope.of(context).unfocus();
    final query = _searchController.text;
    final coord = await dataSource.getCityCoordinates(query);
    final lat = coord['lat'];
    final lon = coord['lon'];
    log('Selected city: $city, lat: $lat, lon: $lon');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  WeatherDetailsBloc(di.getIt<WeatherRepository>())
                    ..add(LoadWeatherDetails(city)),
            ),
            BlocProvider(
              create: (_) =>
                  ForecastBloc(di.getIt<ForecastRepository>())
                    ..add(LoadForecastDetails(lat, lon)),
            ),
          ],

          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: WeatherDetailsPage(cityName: city),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            pinned: true,
            automaticallyImplyLeading: false,
            toolbarHeight: kToolbarHeight - 8,
            titleSpacing: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  child: Text(
                    'Отменить',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.canvasColor,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
            title: Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Hero(
                tag: 'search-field',
                child: Material(
                  color: Colors.transparent,
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    autofocus: true,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Поиск города',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.5),
                        size: 24,
                      ),
                      suffixIcon: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      filled: true,
                      fillColor: Colors.grey[800]!.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      constraints: const BoxConstraints(maxHeight: 35),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          // Список предложений
          if (_suggestions.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final city = _suggestions[index];
                return _buildSuggestionItem(city);
              }, childCount: _suggestions.length),
            ),

          // Заглушка для пустого состояния
          if (_searchController.text.isEmpty)
            const SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.white30),
                  SizedBox(height: 16),
                  Text(
                    'Начните вводить название города',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String city) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        child: Text(
          city,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      onTap: () => _onCitySelected(city),
    );
  }
}

// Дебаунсер для ограничения количества запросов
class _Debouncer {
  final int milliseconds;
  VoidCallback? _callback;
  Timer? _timer;

  _Debouncer({required this.milliseconds});

  void run(VoidCallback callback) {
    _callback = callback;
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), _execute);
  }

  void _execute() {
    _callback?.call();
  }

  void dispose() {
    _timer?.cancel();
  }
}
