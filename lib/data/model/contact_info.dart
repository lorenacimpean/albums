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

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      phoneNumber.hashCode ^
      emailAddress.hashCode ^
      locationInfo.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is ContactInfo &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          phoneNumber == other.phoneNumber &&
          emailAddress == other.emailAddress &&
          locationInfo == other.locationInfo;
}
