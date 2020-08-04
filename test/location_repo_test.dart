import 'package:albums/data/model/result.dart';
import 'package:albums/data/repo/location_repo.dart';
import 'package:albums/themes/strings.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockLocation extends Mock implements Location {}

void main() {
  test('getCurrentLocation Success', () {
    MockLocation mockLocation = MockLocation();
    LocationRepo locationRepo = LocationRepo(location: mockLocation);
    double longitude = 23.58;
    double latitude = 46.77;
    Map<String, double> dataMap = {
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': 1.0,
      'altitude': 0,
      'speed': 1,
      'speedAccuracy': 1,
      'heading': 0,
      'time': 0
    };
    LocationData locationData = LocationData.fromMap(dataMap);
    AppCoordinates expectedCoordinates = AppCoordinates(
      latitude: latitude,
      longitude: longitude,
    );
    when(mockLocation.requestPermission())
        .thenAnswer((_) => Future.value(PermissionStatus.granted));
    when(mockLocation.getLocation())
        .thenAnswer((_) => Future.value(locationData));
    Stream<Result<AppCoordinates>> actualResult =
        locationRepo.getCurrentLocation();

    expect(actualResult, isNotNull);
    expect(actualResult,
        emits(Result<AppCoordinates>.success(expectedCoordinates)));
  });

  test('getCurrentLocation Error', () {
    MockLocation mockLocation = MockLocation();
    LocationRepo locationRepo = LocationRepo(location: mockLocation);

    when(mockLocation.requestPermission())
        .thenAnswer((_) => Future.value(PermissionStatus.denied));
    Stream<Result<AppCoordinates>> actualResult =
        locationRepo.getCurrentLocation();

    expect(actualResult, isNotNull);
    expect(actualResult,
        emits(Result<AppCoordinates>.error(AppStrings.locationError)));
  });

  test('getCurrentLocation Loading', () {
    MockLocation mockLocation = MockLocation();
    LocationRepo locationRepo = LocationRepo(location: mockLocation);

    when(mockLocation.requestPermission())
        .thenAnswer((_) => Future.value(null));
    Stream<Result<AppCoordinates>> actualResult =
        locationRepo.getCurrentLocation();
    expect(actualResult, isNotNull);
    expect(actualResult, emits(Result<AppCoordinates>.loading(null)));
  });
}
