import 'package:food4good_app/utils/constants.dart';

class UserAuthentication {
  final String token;
  final String uuid;

  UserAuthentication(this.token, this.uuid);

  UserAuthentication.fromJson(Map<String, dynamic> json)
      : token = json[Constants.KEY_TOKEN],
        uuid = json[Constants.KEU_UUID];

  Map<String, dynamic> toJson() => {
        Constants.KEY_TOKEN: token,
        Constants.KEU_UUID: uuid,
      };
}
