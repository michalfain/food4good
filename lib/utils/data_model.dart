import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/suppliers_provider.dart';
import 'package:food4good_app/controllers/user_order_provider.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/logger.dart';

class DataModel with ChangeNotifier {
  final String TAG = 'DataModel';
  int _tabIndex = 0;
  bool _isLoadingSuppliers = false;
  bool _isLOadingOrders = false;
  List<OrderDTO> _userOrdersList = [];
  Map<String, SupplierInfoDTO> _supplierItemsMap = {};

  int get tabIndex => _tabIndex;

  set tabIndex(int value) {
    _tabIndex = value;

    notifyListeners();
  }

  List<OrderDTO> get userOrdersList => _userOrdersList;

  set userOrdersList(List<OrderDTO> list) {
    _userOrdersList = list;
    notifyListeners();
  }

  Map<String, SupplierInfoDTO> get supplierItemsMap => _supplierItemsMap;

  set supplierItemsMap(Map<String, SupplierInfoDTO> value) {
    _supplierItemsMap = value;
    notifyListeners();
  }

  bool get isLoadingSuppliers => _isLoadingSuppliers;

  set isLoadingSuppliers(bool value) {
    _isLoadingSuppliers = value;
    notifyListeners();
  }

  void loadSuppliers() {
    isLoadingSuppliers = true;
    SuppliersProvider suppliersProvider = new SuppliersProvider(loadSuppliersDataCallBack);
    suppliersProvider.execute();
  }

  void loadSuppliersDataCallBack(Map<String, SupplierInfoDTO> supplierItems) {
    isLoadingSuppliers = false;
    supplierItemsMap = Map.fromEntries(supplierItems.entries.toList()
      ..sort((supplierItem1, supplierItem2) => supplierItem1.value.compareTo(supplierItem2.value)));
  }

  bool get isLoadingOrders => _isLOadingOrders;

  set isLoadingOrders(bool value) {
    _isLOadingOrders = value;
    notifyListeners();
  }

  void loadOrders() {
    isLoadingOrders = true;
    UserOrderProvider userOrderProvider = new UserOrderProvider(loadOrdersCallBack);
    userOrderProvider.execute();
  }

  void loadOrdersCallBack(dynamic value) {
    if (value is List<dynamic>) {
      List<OrderDTO> finalResponse = new List<OrderDTO>();
      var item;
      for (item in value) {
        finalResponse.add(OrderDTO.fromJson(item));
      }
      userOrdersList = finalResponse;
    } else if (value is String) {
      Logger.log(TAG, message: '[ERROR] getting orders list');
    }
    isLoadingOrders = false;
  }
}
