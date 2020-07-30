import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationRepo {
  geolocator.Geolocator locator;
  Location location = Location();

  Stream<Coordinates> getCurrentLocation() {
    return location.requestPermission().asStream().flatMap((permission) {
      if (permission == PermissionStatus.granted) {
        return location.getLocation().asStream().map((locationData) {
          Coordinates coordinates =
              Coordinates(locationData.latitude, locationData.longitude);
          return coordinates;
        });
      }
      return Stream.value(null);
    });
  }

  Stream<LocationDescription> decodeUserLocation() {
    return getCurrentLocation().flatMap((coordinates) {
      if (coordinates != null) {
        return Geocoder.local
            .findAddressesFromCoordinates(coordinates)
            .asStream()
            .map((addressList) {
          Address adr = addressList.first;
          return LocationDescription(
            street: '${adr.featureName} ${adr.thoroughfare} ',
            country: adr.countryName,
            city: adr.locality,
            zipcode: adr.postalCode,
          );
        });
      }
      return Stream.value(null);
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
}
