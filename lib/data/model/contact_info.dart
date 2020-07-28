import 'package:albums/data/model/location_info.dart';

class ContactInfo {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;
  final LocationInfo locationInfo;

  static const String jsonFirstName = 'firstName';
  static const String jsonLastName = 'lastName';
  static const String jsonPhoneNumber = 'phoneNumber';
  static const String jsonEmailAddress = 'emailAddress';
  static const String jsonLocationInfo = 'locationInfo';

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
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      emailAddress: json['emailAddress'],
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
