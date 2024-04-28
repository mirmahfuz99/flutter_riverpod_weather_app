import 'package:flutter_riverpod_weather_app/core/data/local/storage_const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LocalSavedLocation {
  final FlutterSecureStorage secureStorage;

  LocalSavedLocation({required this.secureStorage});

  void saveLocation(String value) => secureStorage.write(key: LocalStorageConst.kSavedLocation, value: value);

  Future<String> fetchSavedLocation() async {
    try {
      final val =
      await secureStorage.read(key: LocalStorageConst.kSavedLocation);
      return val ?? '';
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}
