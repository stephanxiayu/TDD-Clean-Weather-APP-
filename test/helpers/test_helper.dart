import "package:mockito/annotations.dart";
import "package:weather_ttd_clean_app/domain/repositories/weather_repository.dart";
import "package:http/http.dart" as http;

@GenerateMocks([WeatherRepository],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
