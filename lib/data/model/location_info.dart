import 'package:albums/widgets/app_input_field_widget.dart';

const String jsonStreetAddress = 'streetAddress';
const String jsonCity = 'city';
const String jsonCountry = 'country';
const String jsonZipCode = 'zipCode';

class LocationInfo {
  String streetAddress;
  String city;
  String country;
  String zipCode;

  LocationInfo({
    this.streetAddress,
    this.city,
    this.country,
    this.zipCode,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return LocationInfo(
      streetAddress: json[jsonStreetAddress],
      city: json[jsonCity],
      country: json[jsonCountry],
      zipCode: json[jsonZipCode],
    );
  }

  String fromLocationInfo(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.streetAddressField:
        return this.streetAddress;
        break;
      case FieldType.cityField:
        return this.city;
        break;
      case FieldType.countryField:
        return this.country;
        break;
      case FieldType.zipCodeField:
        return this.zipCode;
        break;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      jsonStreetAddress: streetAddress,
      jsonCity: city,
      jsonCountry: country,
      jsonZipCode: zipCode,
    };
  }
}
