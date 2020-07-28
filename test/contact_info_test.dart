import 'package:albums/data/model/contact_info.dart';
import 'package:albums/data/model/location_info.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> json = {
    'firstName': 'john',
    'lastName': 'test',
    'phoneNumber': '123456789',
    'emailAddress': 'test@test.com',
    'locationInfo': {
      'streetAddress': 'street',
      'city': 'city',
      'country': 'country',
      'zipCode': '123456'
    }
  };
  test('fromJson', () {
    ContactInfo info = ContactInfo.fromJson(json);
    expect(info, isNotNull);
    expect(ContactInfo.fromJson(json), isA<ContactInfo>());
    expect(ContactInfo.fromJson(json).firstName, info.firstName);
    expect(ContactInfo.fromJson(json).firstName, info.firstName);
    expect(ContactInfo.fromJson(json).emailAddress, info.emailAddress);
    expect(ContactInfo.fromJson(json).phoneNumber, info.phoneNumber);
    expect(ContactInfo.fromJson(json).locationInfo.streetAddress,
        info.locationInfo.streetAddress);
    expect(
        ContactInfo.fromJson(json).locationInfo.city, info.locationInfo.city);
    expect(ContactInfo.fromJson(json).locationInfo.country,
        info.locationInfo.country);
    expect(ContactInfo.fromJson(json).locationInfo.zipCode,
        info.locationInfo.zipCode);
  });
  test('toJson', () {
    LocationInfo locationInfo = LocationInfo(
        streetAddress: "street",
        city: "city",
        country: "country",
        zipCode: "123456");
    ContactInfo contactInfo = ContactInfo(
        firstName: "john",
        lastName: "test",
        emailAddress: "test@test.com",
        phoneNumber: "123456789",
        locationInfo: locationInfo);
    expect(contactInfo.toJson(), json);
  });
}
