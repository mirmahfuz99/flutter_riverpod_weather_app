import 'package:flutter_riverpod_weather_app/features/home/domain/weather_info_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SavedLocationNotifier extends StateNotifier<String> {
  SavedLocationNotifier({required this.repo}) : super('') {
    getSavedLocation();
  }

  final WeatherInfoRepository repo;

  void getSavedLocation() async {
    state = await repo.fetchSavedLocation();
  }

  void saveLocation(String location) async {
    await repo.saveLocation(location).then((value) => state = location);
  }
}
