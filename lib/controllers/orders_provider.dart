import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/dto/response.dart';

import 'base_rest_controller.dart';

class OrderProvider extends BaseRestController {
  OrderDTO orderRequest;
  Function orderPlaceCallBack;

  OrderProvider(this.orderRequest, this.orderPlaceCallBack);

  void execute() {
    placeOrder(orderRequest).then((response) => orderPlaceCallBack(response));
  }

  Future<OrderDTO> placeOrder(OrderDTO orderRequest) async {
    ResponseDTO response =
        await executePost("order/init/", orderRequest.toJson());
    print(response.data);
    OrderDTO ordersDTO = OrderDTO.fromJson(response.data);
    return ordersDTO;
  }
}
