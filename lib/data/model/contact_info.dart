import 'package:albums/util/extensions.dart';
import 'package:albums/widgets/app_input_field_widget.dart';

class ContactInfo {
  String firstName;
  String lastName;
  String phoneNumber;
  String emailAddress;
  String streetAddress;
  String city;
  String country;
  String zipCode;

  ContactInfo(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.emailAddress,
      this.streetAddress,
      this.city,
      this.country,
      this.zipCode});

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return ContactInfo(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      emailAddress: json['emailAddress'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      country: json['country'],
      zipCode: json['zipCode'],
    );
  }


  String fromContactInfo(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.firstNameField:
        return this.firstName;
        break;
      case FieldType.lastNameField:
        return this.lastName;
        break;
      case FieldType.emailAddressField:
        return this.emailAddress;
        break;
      case FieldType.phoneNumberField:
        return this.phoneNumber;
        break;
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

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'emailAddress': emailAddress,
        'streetAddress': streetAddress,
        'city': city,
        'country': country,
        'zipCode': zipCode,
      };
}
