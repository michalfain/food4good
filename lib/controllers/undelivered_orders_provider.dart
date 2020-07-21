import 'package:food4good_app/controllers/base_rest_controller.dart';
import 'package:food4good_app/dto/response.dart';
import 'package:food4good_app/utils/logger.dart';

class UndeliveredOrdersProvider extends BaseRestController {
  static final String TAG = "UndeliveredOrdersProvider";
  Function loadOrderNoCallBack;

  UndeliveredOrdersProvider(this.loadOrderNoCallBack);

  void execute() {
    var undelivered = loadOrderNo().then(
      (response) => {
        Logger.log(TAG, message: response.toString()),
        if (response != null && response is Map && response.isNotEmpty)
          {
            loadOrderNoCallBack(response["udelivered"]),
          }
        else
          {
            loadOrderNoCallBack(0)
          }
      },
    );
  }

  Future loadOrderNo() async {
    print("------------loadOrderNo----------");
    ResponseDTO response = await executeGet("order/undelivered");
    if (response != null) {
      print(response.data);
      return response.data;
    } else {
      return "";
    }
  }
}
