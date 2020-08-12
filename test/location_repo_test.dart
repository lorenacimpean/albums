import 'package:albums/data/repo/location_repo.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoder/services/base.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

class MockGeocoding extends Mock implements Geocoding {}

class MockLocation extends Mock implements Location {}

void main() {
  MockLocation mockLocation = MockLocation();
  MockGeocoding mockGeocoding = MockGeocoding();
  LocationRepo locationRepo = LocationRepo(
    mockLocation,
    mockGeocoding,
  );
  double longitude = 23.58;
  double latitude = 46.77;
  AppCoordinates expectedCoordinates = AppCoordinates(
    latitude: latitude,
    longitude: longitude,
  );

  test('getCurrentLocation Success', () {
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

    when(mockLocation.requestPermission())
        .thenAnswer((_) => Future.value(PermissionStatus.granted));
    when(mockLocation.getLocation())
        .thenAnswer((_) => Future.value(locationData));
    Stream<AppCoordinates> actualResult = locationRepo.getCurrentLocation();

    expect(
      actualResult,
      emits(expectedCoordinates),
    );
  });

  test('getCurrentLocation permission denied => Error', () {
    when(mockLocation.requestPermission())
        .thenAnswer((_) => Future.value(PermissionStatus.denied));
    Stream<AppCoordinates> actualResult = locationRepo.getCurrentLocation();
    expect(actualResult, isNotNull);
    expect(
      actualResult,
      emitsError(AppStrings.locationError),
    );
  });

  test('getCurrentLocation permission denied forever => Error', () {
    when(mockLocation.requestPermission())
        .thenAnswer((_) => Future.value(PermissionStatus.deniedForever));
    Stream<AppCoordinates> actualResult = locationRepo.getCurrentLocation();
    expect(actualResult, isNotNull);
    expect(actualResult, isNotNull);
    expect(
      actualResult,
      emitsError(AppStrings.locationError),
    );
  });

  test('decode user location => appAdress', () {
    AppAddress testAddress = AppAddress(
      coordinates: expectedCoordinates,
      thoroughfare: "Strada Câmpul Pâinii",
      featureName: "3-5",
      countryName: "Romania",
      cityName: "Cluj-Napoca",
      postalCode: "400000",
    );

    when(mockGeocoding.findAddressesFromCoordinates(expectedCoordinates))
        .thenAnswer((_) => Future.value([testAddress]));
    Stream<AppAddress> actualResult =
        locationRepo.decodeUserLocation(expectedCoordinates);
    expect(actualResult, isNotNull);
    expect(
      actualResult,
      emits(
        testAddress,
      ),
    );
  });

  test('decode user location => first Adress from list', () {
    AppAddress testAddress1 = AppAddress(
      coordinates: expectedCoordinates,
      thoroughfare: "Test",
      featureName: "234",
      countryName: "Test",
      cityName: "Test",
      postalCode: "123",
    );
    AppAddress testAddress2 = AppAddress(
      coordinates: expectedCoordinates,
      thoroughfare: "Strada Câmpul Pâinii",
      featureName: "3-5",
      countryName: "Romania",
      cityName: "Cluj-Napoca",
      postalCode: "400000",
    );
    List<AppAddress> testList = [];
    testList.add(testAddress1);
    testList.add(testAddress2);

    when(mockGeocoding.findAddressesFromCoordinates(expectedCoordinates))
        .thenAnswer((_) => Future.value(testList));
    Stream<AppAddress> actualResult =
        locationRepo.decodeUserLocation(expectedCoordinates);
    expect(
      actualResult,
      emits(
        testAddress1,
      ),
    );
    expect(actualResult, isNotNull);
  });

  test('decode user location => error, address list null', () {
    List<AppAddress> testList = [];
    when(mockGeocoding.findAddressesFromCoordinates(expectedCoordinates))
        .thenAnswer((_) => Future.value(testList));
    Stream<AppAddress> actualResult =
        locationRepo.decodeUserLocation(expectedCoordinates);
    expect(
      actualResult,
      emitsError(
        AppStrings.noAddressesError,
      ),
    );
  });

  test('decode user location => error, address list empty', () {
    List<AppAddress> testList = [];

    when(mockGeocoding.findAddressesFromCoordinates(expectedCoordinates))
        .thenAnswer((_) => Future.value(testList));
    Stream<AppAddress> actualResult =
        locationRepo.decodeUserLocation(expectedCoordinates);
    expect(
      actualResult,
      emitsError(
        AppStrings.noAddressesError,
      ),
    );
    expect(actualResult, isNotNull);
  });
}
