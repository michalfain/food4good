import 'package:enum_to_string/enum_to_string.dart';
import 'package:food4good_app/dto/enum_order_status.dart';
import 'package:food4good_app/utils/constants.dart';

class OrderDTO {
  int supplierId;
  int userId;
  String totalPrice;
  int id;
  OrderStatus status;
  String createdAt;
  String updatedAt;
  String supplierName;
  int numOfProducts;
  String pickUpAddress;
  String pickUpTime;
  String productId;
  String comment;
  int orderId;
  bool isOrderDelivered;

  static final String columnId = 'id';

  OrderDTO({
    int supplierId,
    int userId,
    int id,
    int orderId,
    int numOfProducts,
    String totalPrice,
    String pickUpAddress,
    String pickupTime,
    String productId,
    String comment,
    OrderStatus status,
    String createdAt,
    String updatedAt,
    String supplierName,
  }) {
    this.userId = userId;
    this.supplierId = supplierId;
    this.id = id;
    this.numOfProducts = numOfProducts;
    this.totalPrice = totalPrice;
    this.pickUpAddress = pickUpAddress;
    this.pickUpTime = pickupTime;
    this.status = status;
    this.comment = comment;
    this.productId = productId;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.supplierName = supplierName;
    this.orderId = orderId;
  }

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    //TODO: Michal: what if there is no products at all ? Can there be an order without products.
    //TODO: Michal: Are we receiving here an array of products?

    var productAmount;
    var products = json[Constants.KEY_PRODUCTS];
    var isProductsNull = products == null;
    if (!isProductsNull) {
      var productsList = products as List;
      var isProductListEmpty = productsList.isEmpty;
      if (!isProductListEmpty) {
        var firstItem = productsList[0];
        productAmount = firstItem[Constants.KEY_PRODUCT_AMOUNT];
      }
    }

    OrderDTO ordersDTO = OrderDTO(
        createdAt: json[Constants.KEY_CREATED_AT],
        updatedAt: json[Constants.KEY_UPDATED_AT],
        //TODO: Emil: There can be several items per order,
        //there for number of items should be per-product and not as a single value per order.
        //Need to discuss with server side.
        //numOfProducts: products != null && (products as List).isNotEmpty ? products[0][Constants.KEY_NUM_OF_PRODUCTS] : 0,
        numOfProducts: productAmount,
        status: EnumToString.fromString(OrderStatus.values, json[Constants.KEY_STATUS]),
        id: json[Constants.KEY_ID],
        orderId: json[Constants.KEY_ORDER_ID],
        totalPrice: json[Constants.KEY_TOTAL_PRICE],
        pickupTime: json[Constants.KEY_PICKUP_TIME],
        pickUpAddress: json[Constants.KEY_ADDRESS],
        userId: json[Constants.KEY_USER_ID],
        supplierId: json[Constants.KEY_SUPPLIER_ID],
        supplierName: json[Constants.KEY_SUPPLIER_NAME]);
    return ordersDTO;
  }

  Map<String, dynamic> toJson() => {
        Constants.KEY_COMMENTS: comment,
        Constants.KEY_PRODUCTS_ROWS: [
          {Constants.KEY_PRODUCT_AMOUNT: numOfProducts, Constants.KEY_PRODUCT_ID: productId}
        ],
        Constants.KEY_SUPPLIER_ID: supplierId
      };
}
