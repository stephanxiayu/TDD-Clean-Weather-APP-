import 'package:dartz/dartz.dart';
import 'package:weather_ttd_clean_app/core/error/failure.dart';
import 'package:weather_ttd_clean_app/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityname);
}
