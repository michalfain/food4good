import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/dto/upper_bar_config.dart';

import 'widget_discount.dart';
import 'widget_rest_info.dart';
import 'no_dishes_left.dart';
import 'upper_bar.dart';

class SupplierItem extends StatelessWidget {
  SupplierInfoDTO supplierInfoDTO;
  UpperBarConfig _upperBarConfig = new UpperBarConfig(true, true, true, true, true, true, true, true);
  int _discount;
  String _numOfDishesLeft;

  SupplierItem(this.supplierInfoDTO);

  @override
  Widget build(BuildContext context) {
    _discount = int.tryParse(supplierInfoDTO.discount.substring(0, 2));
    _numOfDishesLeft = supplierInfoDTO.numOfDishes;

    Size size = MediaQuery.of(context).size;
    double _itemHeight = size.height / 4;
    double _discountWidth = size.width - 8;
    double _discountHeight = size.height / 5;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        elevation: 2,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                UpperBar(supplierInfoDTO, _upperBarConfig),
                _getDiscount(_discountHeight, _discountWidth),
              ],
            ),
            _getBottomBar(),
          ],
        ),
      ),
    );
  }

  //This method returns the logo of the restaurant

  _getDiscount(_discountHeight, _discountWidth) {
    return Padding(
        padding: EdgeInsets.fromLTRB(_discountWidth / 17, 0, 20.0, 0),
        child: DiscountWidget(_discount.toString() + '%', _discountHeight, _discountWidth));
  }

  _getBottomBar() {
    if (_numOfDishesLeft != '0')
      return GetInfo(supplierInfoDTO, false);
    //if no dishes left
    else
      return Stack(
        children: <Widget>[
          GetInfo(supplierInfoDTO, false),
          NoDishesLeft(supplierInfoDTO),
        ],
      );
  }

  int compareTo(SupplierItem other) {
    int thisDestinationInt = isNullEmpty(this.supplierInfoDTO.distance) ? 0 : getIntDestination(this.supplierInfoDTO.distance);
    int otherDestinationInt = isNullEmpty(other.supplierInfoDTO.distance) ? 0 : getIntDestination(other.supplierInfoDTO.distance);
    return thisDestinationInt.compareTo(otherDestinationInt);
  }

  int getIntDestination(String distance) {
    //for KM distance
    if (distance.contains("km")) {
      double destination = double.parse(distance.split("km")[0].trim());
      return (destination * 1000).round();
    }
    if (distance.contains("ק\"מ")) {
      double destination = double.parse(distance.split("ק\"מ")[0].trim());
      return (destination * 1000).round();
    }
    //for meter distance
    if (distance.contains("m")) {
      int destination = int.parse(distance.split("m")[0].trim());
      return destination;
    }
    if (distance.contains("מ'")) {
      int destination = int.parse(distance.split("מ'")[0].trim());
      return destination;
    }
  }

  bool isNullEmpty(Object o) => o == null || "" == o;
}
