import 'package:app/core/theme/theme.dart';
import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';
import 'package:app/features/weather/presentation/logic/favorites_bloc/favorites_bloc.dart';
import 'package:app/features/weather/presentation/pages/weather_home_page.dart';
import 'package:app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherEntityAdapter());
  await setupLocator();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final talker = getIt<Talker>();
    return MultiBlocProvider(
      providers: [
        Provider<Talker>.value(value: talker),
        BlocProvider(
          create: (context) => getIt<FavoritesBloc>()..add(LoadFavorites()),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: theme,
        home: WeatherHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
