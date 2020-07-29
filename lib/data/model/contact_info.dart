import 'package:albums/data/model/location_info.dart';

const String jsonFirstName = 'firstName';
const String jsonLastName = 'lastName';
const String jsonPhoneNumber = 'phoneNumber';
const String jsonEmailAddress = 'emailAddress';
const String jsonLocationInfo = 'locationInfo';

class ContactInfo {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;
  final LocationInfo locationInfo;

  ContactInfo(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.emailAddress,
      this.locationInfo});

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return ContactInfo(
      firstName: json[jsonFirstName],
      lastName: json[jsonLastName],
      phoneNumber: json[jsonPhoneNumber],
      emailAddress: json[jsonEmailAddress],
      locationInfo: LocationInfo.fromJson(json[jsonLocationInfo]),
    );
  }

  Map<String, dynamic> toJson() => {
        jsonFirstName: firstName,
        jsonLastName: lastName,
        jsonPhoneNumber: phoneNumber,
        jsonEmailAddress: emailAddress,
        jsonLocationInfo: locationInfo.toJson()
      };
}
