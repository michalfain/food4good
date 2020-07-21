//This class gets a password and a userName and
// returns a specific token (for the orders data) and id (for the rest data).
//also checks if the userName and Password are correct.

import 'package:food4good_app/controllers/base_rest_controller.dart';
import 'package:food4good_app/dto/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends BaseRestController {
  ResponseDTO response;
  Function loginCallBack;

  LoginProvider(this.loginCallBack);

  void execute(userName, password) {
    login(userName, password).then((response) => _setResult(response));
  }

  login(userName, password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(ADMIN_TOKEN_KEY);
    return response = await executePost(
        "login/admin", {"email": userName, "password": password});
  }

  _setResult(ResponseDTO response) {
    if (!response.is_error) {
      print("admin token from Login ${response.data['token']}");
      BaseRestController.cachingValue[ADMIN_TOKEN_KEY] =
          '${response.data['token']}';
      this.loginCallBack(true, '${response.data['token']}');
    } else
      this.loginCallBack(false, '');
  }
}
