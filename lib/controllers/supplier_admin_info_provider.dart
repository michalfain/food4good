import 'package:food4good_app/dto/response.dart';

import 'base_rest_controller.dart';

class SupplierAdminInfoProvider extends BaseRestController {
  Function adminInfoCallBack;
  ResponseDTO response;

  SupplierAdminInfoProvider(this.adminInfoCallBack);

  void execute() {
    getAdminInfo().then((response) => _setResult(response));
  }

  getAdminInfo() async {
    return response = await executeGet("admin/supplier", isAdmin: true);
  }

  _setResult(ResponseDTO response) {
    if (!response.is_error) {
      this.adminInfoCallBack(true, response.data);
    } else {
      this.adminInfoCallBack(false, null);
      print(response.errorMsg);
    }
  }
}
