import 'package:food4good_app/controllers/base_rest_controller.dart';
import 'package:food4good_app/dto/response.dart';

class UpdateSupplierDataController extends BaseRestController {
  ResponseDTO response;
  Function supplierDataCallBack;

  UpdateSupplierDataController(this.supplierDataCallBack);

  void execute(jsonSupplierStaticData) {
    updateData(jsonSupplierStaticData).then((response) => _setResult(response));
  }

  updateData(jsonSupplierStaticData) async {
    return response = await executePost("admin/update", jsonSupplierStaticData,
        isAdmin: true);
  }

  _setResult(ResponseDTO response) {
    if (response != null) if (!response.is_error) {
      this.supplierDataCallBack(true, "succeeded");
    } else {
      this.supplierDataCallBack(false, response.errorMsg);
      print(response.errorMsg);
    }
    else {
      this.supplierDataCallBack(false, "response is null");
    }
  }
}
