

enum APIPath {
  // * by city location
  byCityLocation,
  // * by Latitude and Longitude
  byLatLon
}

class APIPathHelper {
  // global api base url
  static const String baseUrl = "http://api.weatherapi.com/v1";
  static const String apiKey = "00459528015a4bbba5a183641242604";

  static String currentWeather(APIPath path,
      {String? location, String? latLon}) {
        return "/forecast.json?key=$apiKey&q=$latLon";
  }
}
