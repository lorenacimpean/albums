import 'package:albums/data/model/result.dart';
import 'package:albums/themes/strings.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationRepo {
  final Location location;

  LocationRepo({Location location}) : this.location = location ?? Location();

  Stream<Result<Coordinates>> getCurrentLocation() {
    return location.requestPermission().asStream().flatMap((permission) {
      if (permission == PermissionStatus.granted) {
        return location.getLocation().asStream().map((locationData) {
          Coordinates coordinates =
              Coordinates(locationData.latitude, locationData.longitude);
          return Result<Coordinates>.success(coordinates);
        });
      }
      if (permission == PermissionStatus.denied) {
        return Stream.value(
            Result<Coordinates>.error(AppStrings.locationError));
      }
      return Stream.value(Result<Coordinates>.loading(null));
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
