import 'package:flutter_riverpod_weather_app/features/home/data/entity/weather.dart';
import '../../../core/data/remote/api_result.dart';

abstract class WeatherInfoRepository {

  Future<ApiResult<Weather>> getWeatherInfoByLocation(String city);

  Future<ApiResult<Weather>> getWeatherInfoByCurrentLocation();

  Future<String> fetchSavedLocation();

  Future<void> saveLocation(String location);

}
