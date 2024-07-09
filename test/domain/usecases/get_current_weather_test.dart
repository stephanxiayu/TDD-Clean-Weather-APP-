import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_ttd_clean_app/domain/entities/weather.dart';
import 'package:weather_ttd_clean_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetails = WeatherEntity(
      cityName: "Berlin",
      main: "Clouds",
      description: "few clouds",
      iconCode: "02d",
      temperature: 32,
      pressure: 1009,
      humidity: 55);

  const testCityName = "Berlin";

  test("should get current weather detail from repository", () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetails));
    //act
    final result = await getCurrentWeatherUseCase.execute(testCityName);
    //assert

    expect(result, const Right(testWeatherDetails));
  });
}
