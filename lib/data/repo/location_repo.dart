import 'package:albums/data/model/result.dart';
import 'package:albums/themes/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationRepo {
  final Location location;

  LocationRepo({Location location}) : this.location = location ?? Location();

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
      if (permission == PermissionStatus.denied) {
        return Stream.value(
            Result<AppCoordinates>.error(AppStrings.locationError));
      }
      return Stream.value(Result<AppCoordinates>.loading(null));
    });
  }

  Stream<Address> decodeUserLocation(Coordinates coordinates) {
    return Geocoder.local
        .findAddressesFromCoordinates(coordinates)
        .asStream()
        .map((addressList) {
      return addressList?.first;
    });
  }
}

class AppCoordinates extends Coordinates {
  final double latitude;
  final double longitude;

  AppCoordinates({@required this.latitude, @required this.longitude})
      : super(latitude, longitude);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppCoordinates &&
          latitude == other.latitude &&
          longitude == other.longitude;
}
