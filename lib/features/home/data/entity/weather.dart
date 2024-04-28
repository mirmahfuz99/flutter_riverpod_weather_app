import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';


@freezed
 class Weather with _$Weather {
  const Weather._();

  const factory Weather({
    @JsonKey(name: 'location') Location? location,
    @JsonKey(name: 'current') Current? current,
    @JsonKey(name: 'forecast') Forecast? forecast,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
 class Current with _$Current {
  const factory Current({
    @JsonKey(name: 'last_updated') String? lastUpdated,
    @JsonKey(name: 'temp_c') dynamic tempC,
    @JsonKey(name: 'feelslike_c') dynamic feelsLikeTempC,
    @JsonKey(name: 'temp_f') double? tempF,
    @JsonKey(name: 'uv') dynamic uv,
    @JsonKey(name: 'is_day') dynamic isDay,
    @JsonKey(name: 'condition') Condition? condition,
  }) = _Current;

  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
}

@freezed
 class Condition with _$Condition {
  const factory Condition({
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'icon') String? icon,
  }) = _Condition;

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
}

@freezed
 class Location with _$Location {
  const factory Location({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'localtime') String? localtime,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class Forecast with _$Forecast {
  const factory Forecast({
    @JsonKey(name: 'forecastday') List<Forecastday>? forecastday,
  }) = _Forecast;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
}


@freezed
class Forecastday with _$Forecastday {
  const factory Forecastday({

    @JsonKey(name: 'astro') Astro? astro,
    @JsonKey(name: 'hour') List<Hour>? hours,
  }) = _Forecastday;

  factory Forecastday.fromJson(Map<String, dynamic> json) =>
      _$ForecastdayFromJson(json);
}



@freezed
class Astro with _$Astro {
  const factory Astro({
    @JsonKey(name: 'sunrise') String? sunrise,
    @JsonKey(name: 'sunset') String? sunset,
  }) = _Astro;

  factory Astro.fromJson(Map<String, dynamic> json) =>
      _$AstroFromJson(json);
}

@freezed
class Hour with _$Hour {
  const factory Hour({
    @JsonKey(name: 'time') String? time,
    @JsonKey(name: 'temp_c')  dynamic tempC,
    @JsonKey(name: 'condition') Condition? condition,
  }) = _Hour;

  factory Hour.fromJson(Map<String, dynamic> json) =>
      _$HourFromJson(json);
}