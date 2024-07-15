import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_ttd_clean_app/core/constant/constants.dart';
import 'package:weather_ttd_clean_app/core/error/exception.dart';
import 'package:weather_ttd_clean_app/data/data_sources/remote_data_source.dart';
import "package:http/http.dart" as http;
import 'package:weather_ttd_clean_app/data/models/weather_model.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;

  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = "New York";
  group("get current weather", () {
    test("should return weather model when the response is 200", () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
              readJson("helpers/dummy_data/dummy_weather_response.json"), 200));

      //act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      //assert

      expect(result, isA<WeatherModel>());
    });
    test("should throw an error when response code is 404 or other ", () async {
      //arrage
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response("Not found", 404));

      //act
      final result =
          weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      //assert

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
