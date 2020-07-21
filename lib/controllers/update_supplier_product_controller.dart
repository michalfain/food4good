import 'package:food4good_app/controllers/base_rest_controller.dart';
import 'package:food4good_app/dto/response.dart';

class UpdateSupplierProductController extends BaseRestController {
  ResponseDTO response;
  Function supplierProductCallBack;

  UpdateSupplierProductController(this.supplierProductCallBack);

  void execute(_supplierInfoProduct) {
    updateData(_supplierInfoProduct).then((response) => _setResult(response));
  }

  updateData(_supplierInfoProduct) async {
    return response = await executePost(
      "admin/update/product",
      _supplierInfoProduct,
      isAdmin: true,
    );
  }

  _setResult(ResponseDTO response) {
    if (response != null) {
      if (!response.is_error) {
        this.supplierProductCallBack(true, "updated!!");
      } else
        this.supplierProductCallBack(false, response.errorMsg);
      print(response.errorMsg);
    } else {
      this.supplierProductCallBack(false, "response is null");
    }
  }
}
