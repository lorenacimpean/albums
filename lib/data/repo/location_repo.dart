import 'package:albums/data/model/result.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationRepo {
  final Location location;

  LocationRepo({Location location}) : this.location = location ?? Location();

  Stream<Result> getCurrentLocation() {
    return location.requestPermission().asStream().flatMap((permission) {
      if (permission == PermissionStatus.granted) {
        return location.getLocation().asStream().map((locationData) {
          Coordinates coordinates =
              Coordinates(locationData.latitude, locationData.longitude);
          return Result.success(coordinates);
        });
      }
      if (permission == PermissionStatus.denied) {
        return Stream.value(Result.error("Location Permission was denied"));
      }
      return Stream.value(Result.loading("loading"));
    });
  }

  Stream<Address> decodeUserLocation(Coordinates coordinates) {
    return Geocoder.local
        .findAddressesFromCoordinates(coordinates)
        .asStream()
        .map((addressList) {
      return addressList.first;
    });
  }
}

class LocationDescription {
  final street;
  final city;
  final country;
  final zipcode;

  LocationDescription({
    this.street,
    this.city,
    this.country,
    this.zipcode,
  });

  factory LocationDescription.fromAddress(Address address) {
    return LocationDescription(
      street: '${address.featureName} ${address.thoroughfare} ',
      country: address.countryName,
      city: address.locality,
      zipcode: address.postalCode,
    );
  }
}
