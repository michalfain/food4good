import 'package:food4good_app/utils/constants.dart';

class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation(this.latitude, this.longitude);

  UserLocation.fromJson(Map<String, dynamic> json)
      : latitude = json[Constants.KEY_LATITUDE],
        longitude = json[Constants.KEY_LONGITUDE];

  Map<String, dynamic> toJson() => {
        Constants.KEY_LATITUDE: latitude.toString(),
        Constants.KEY_LONGITUDE: longitude.toString(),
      };
}
