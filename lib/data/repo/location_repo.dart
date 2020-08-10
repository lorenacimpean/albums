import 'package:albums/data/model/result.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationRepo {
  Location location;
  Geocoding geocoding;

  LocationRepo({this.location, this.geocoding}) {
    this.location = location ?? Location();
    this.geocoding = geocoding ?? Geocoder.local;
  }

  Stream<Result<AppCoordinates>> getCurrentLocation() {
    return location.requestPermission().asStream().flatMap((permission) {
      if (permission == PermissionStatus.granted) {
        return location.getLocation().asStream().map((locationData) {
          AppCoordinates coordinates = AppCoordinates(
              latitude: locationData.latitude,
              longitude: locationData.longitude);
          return Result<AppCoordinates>.success(coordinates);
        });
      }
      return Stream.value(
          Result<AppCoordinates>.error(AppStrings.locationError));
    });
  }

  Stream<Result<AppAddress>> decodeUserLocation(AppCoordinates coordinates) {
    return geocoding
        .findAddressesFromCoordinates(coordinates)
        .asStream()
        .map((addressList) {
      if (addressList?.isNotEmpty ?? true) {
        Address currentAddress = addressList?.first;
        return Result<AppAddress>.success(
            AppAddress.fromAddress(currentAddress));
      }
      return Result<AppAddress>.error(AppStrings.noAddressesError);
    });
  }
}

class AppCoordinates extends Coordinates {
  final double latitude;
  final double longitude;

  AppCoordinates({@required this.latitude, @required this.longitude})
      : super(latitude, longitude);

  factory AppCoordinates.fromCoordinates(Coordinates coordinates) {
    return AppCoordinates(
        latitude: coordinates.latitude, longitude: coordinates.longitude);
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppCoordinates &&
          latitude == other.latitude &&
          longitude == other.longitude;
}

class AppAddress extends Address {
  final AppCoordinates coordinates;
  final String featureName;
  final String thoroughfare;
  final String countryName;
  final String cityName;
  final String postalCode;

  AppAddress(
      {this.coordinates,
      this.featureName,
      this.thoroughfare,
      this.countryName,
      this.cityName,
      this.postalCode})
      : super(
          coordinates: coordinates,
          featureName: featureName,
          thoroughfare: thoroughfare,
          countryName: countryName,
          locality: cityName,
          postalCode: postalCode,
        );

  factory AppAddress.fromAddress(Address address) {
    return AppAddress(
      coordinates: AppCoordinates.fromCoordinates(address.coordinates),
      featureName: address.featureName,
      thoroughfare: address.thoroughfare,
      countryName: address.countryName,
      cityName: address.locality,
      postalCode: address.postalCode,
    );
  }

  @override
  int get hashCode =>
      coordinates.hashCode ^
      featureName.hashCode ^
      thoroughfare.hashCode ^
      countryName.hashCode ^
      cityName.hashCode ^
      postalCode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppAddress &&
          coordinates == other.coordinates &&
          featureName == other.featureName &&
          thoroughfare == other.thoroughfare &&
          countryName == other.countryName &&
          cityName == other.cityName &&
          postalCode == other.postalCode;
}
