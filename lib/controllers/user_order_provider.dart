import 'package:food4good_app/controllers/base_rest_controller.dart';
import 'package:food4good_app/dto/response.dart';
import 'package:food4good_app/utils/logger.dart';

class UserOrderProvider extends BaseRestController {
  static final String TAG = "UserOrderProvider";

  Function _loadOrdersCallBack;

  UserOrderProvider(Function loadOrdersCallBack) {
    _loadOrdersCallBack = loadOrdersCallBack;
  }

  void execute() {
    var orders = loadOrder().then((response) => _loadOrdersCallBack(response != null ? response : 0));
    //    var orders = loadOrder().then((response) => _parseOrders(response));
  }

  Future loadOrder() async {
    Logger.log(TAG, message: "------------loadOrders!!!!!!----------");

    ResponseDTO response = await executeGet("order/all");
    if (response != null) {
      Logger.log(TAG, message: "load order : ${response.data.toString()}");
      return response.data;
    } else {
      return null;
    }
  }

//  void _parseOrders(List<dynamic> ordersList) {
//    List<UserOrderDTO> userOrderListAll = ordersList.cast<UserOrderDTO>();
//    Map<dynamic, OpenOrder> userOrders = {};
//    for (var order in userOrderListAll) {
//      OpenOrder item = OpenOrder(order);
//      userOrders[order.id] = item;
//    }
//    this._loadOrdersCallBack(userOrders);
//  }
}
