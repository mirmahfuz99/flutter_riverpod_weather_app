

import 'package:flutter_riverpod_weather_app/core/data/entities/result_state.dart';
import 'package:flutter_riverpod_weather_app/features/home/data/datasource/local/local_saved_location.dart';
import 'package:flutter_riverpod_weather_app/features/home/data/datasource/local/location_services.dart';
import 'package:flutter_riverpod_weather_app/features/home/data/datasource/remote/weather_remote_data_source.dart';
import 'package:flutter_riverpod_weather_app/features/home/data/repository/weather_repository_impl.dart';
import 'package:flutter_riverpod_weather_app/features/home/domain/weather_info_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _remoteDataSourceWeatherInfo = Provider<WeatherRemoteDataSource>((ref) =>
    WeatherRemoteDataSourceImpl(dioClient: ref.watch(dioClientProvider)));

final _locationService =
Provider<LocationServices>((ref) => LocationServices());

final _savedLocationService = Provider<LocalSavedLocation>(
        (ref) => LocalSavedLocation(secureStorage: ref.watch(sharedPrefsProvider)));
final _weatherRepository = Provider<WeatherInfoRepository>((ref) =>
    WeatherInfoRepositoryImpl(
        remoteDataSource: ref.watch(_remoteDataSourceWeatherInfo),
        networkInfo: ref.watch(networkInfoProvider),
        locationServices: ref.watch(_locationService),
        savedLocationLocal: ref.watch(_savedLocationService)));

final weatherInfoNotifier =
StateNotifierProvider<WeatherInfoNotifier, ResultState>(
        (ref) => WeatherInfoNotifier(repo: ref.watch(_weatherRepository)));

final savedLocationNotifier =
StateNotifierProvider<SavedLocationNotifier, String>(
        (ref) => SavedLocationNotifier(repo: ref.watch(_weatherRepository)));
