//This class gets a specific token and return the restaurant orders.

import 'package:food4good_app/controllers/base_rest_controller.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/dto/response.dart';
import 'package:food4good_app/widgets/orders_details_frame.dart';

class OrdersBySupplierProvider extends BaseRestController {
  Function loadSupplierOrdersCallBack;

//put Orders in  map and arrange it by dates. the key is the token.
  // List ordersList1 = new List<OrdersDTO>();
  // List mapOfOrders = new List<OrdersDTO>();
  // Map ordersMap = Map<String, Map>(); //THE TOKEN IS THE KEY. the value is map of orders belong to the restaurant
  //OrdersDTO order1 = OrdersDTO(
  //  supplierId: "1", userId: 123456, orderId: 1, date: '1-2-2020', numberOfBought: 30, totalCost: 80.toString(), status: 2);
  //OrdersDTO order2 = OrdersDTO(
  //  supplierId: "1", userId: 123456, orderId: 2, date: '4-3-2020', numberOfBought: 16, totalCost: 40.toString(), status: 1);
  //OrdersDTO order3 = OrdersDTO(
  //  supplierId: "1", userId: 123456, orderId: 3, date: '15-2-2020', numberOfBought: 7, totalCost: 35.toString(), status: 2);
  // OrdersDTO order4 = OrdersDTO(
  //   supplierId: "1", userId: 123456, orderId: 4, date: '15-2-2020', numberOfBought: 2, totalCost: 40.toString(), status: 2);
  //OrdersDTO order5 = OrdersDTO(
  //  supplierId: "1", userId: 123456, orderId: 5, date: '1-3-2020', numberOfBought: 6, totalCost: 50.toString(), status: 2);

  OrdersBySupplierProvider(this.loadSupplierOrdersCallBack) {
    //ordersList1 = [order1, order2, order3, order4, order5];
    //ordersMap = {'@#wes': ordersList1, 'f*(Ga': ordersList1, '12hS%': ordersList1};
  }

  //getOrders(String token) {
  //mapOfOrders = ordersMap[token];
  //return mapOfOrders;
  //}

  void execute(token) {
    setOrders(token).then((response) => _setResult(response));
  }

  _setResult(ResponseDTO response) {
    if (!response.is_error)
      this.loadSupplierOrdersCallBack(response.data);
//      .map((item) => OrdersDTO.fromJson(item))
//         .toList());
    else
      this.loadSupplierOrdersCallBack([response.errorMsg, 'try again']);
  }

  setOrders(token) async {
    ResponseDTO response;
    response = await executeGet("order/admin/all", isAdmin: true);
    return response;
  }

//  void _convertToOrdersItemsMap(List<dynamic> responseList) {
//    List<OrdersDTO> ordersDTOList =
//    responseList.cast<OrdersDTO>();
//    Map<String, OrdersDetailsFrame> OrderItems = {};
//    for (var OrdersDTO in ordersDTOList) {
//      OrdersDetailsFrame item = OrdersDetailsFrame(OrdersDTO);
//      OrderItems[OrdersDTO.supplierId] = item;
//    }
//    this.loadSupplierOrdersCallBack(OrderItems);
//  }

}
