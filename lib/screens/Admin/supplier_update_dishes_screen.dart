import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food4good_app/controllers/update_supplier_product_controller.dart';
import 'package:food4good_app/controllers/supplier_admin_info_provider.dart';
import 'package:food4good_app/dto/product.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/widgets/widget_headline.dart';

import 'supplier_home_page_screen.dart';

class SupplierUpdateDishesScreen extends StatefulWidget {
  final String token;
  static const String SCREEN_NAME = 'SupplierUpdateDishesScreen';

  SupplierUpdateDishesScreen({
    Key key,
    this.token,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SupplierUpdateDishesScreen();
  }
}

class _SupplierUpdateDishesScreen extends State<SupplierUpdateDishesScreen> {
  UpdateSupplierProductController _updateSupplierProduct;
  String kinds, pickUpFrom, rangeFrom, rangeTo, cost, discount, amount, max;
  String msg = '';
  int _fridayStartHour = 22;
  int _fridayEndHour = 22;
  int _startHour = 22;
  int _endHour = 22;
  int _saturdayStartHour = 22;
  int _saturdayEndHour = 22;
  dynamic data;

  String jsonSupplierInfoDTO = '';
  SupplierAdminInfoProvider _getSupplierAdminInfo;
  Map _productMap;
  ProductDTO _productDto;

  //Controllers for the different text fields
  final _controllerKinds = TextEditingController();
  final _controllerPickUpFrom = TextEditingController();
  final _controllerFridayPickUpFrom = TextEditingController();
  final _controllerSaturdayPickUpFrom = TextEditingController();
  final _controllerFridayPickUpUntil = TextEditingController();
  final _controllerPickUpUntil = TextEditingController();
  final _controllerSaturdayPickUpUntil = TextEditingController();
  final _controllerAmount = TextEditingController();
  final _controllerMaxAmountToPick = TextEditingController();
  final _controllerCost = TextEditingController();
  final _controllerRangeFrom = TextEditingController();
  final _controllerRangeTo = TextEditingController();
  final _controllerDiscount = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerAmount.dispose();
    _controllerMaxAmountToPick.dispose();
    _controllerPickUpFrom.dispose();
    _controllerPickUpUntil.dispose();
    _controllerFridayPickUpFrom.dispose();
    _controllerFridayPickUpUntil.dispose();
    _controllerSaturdayPickUpFrom.dispose();
    _controllerSaturdayPickUpUntil.dispose();
    _controllerRangeFrom.dispose();
    _controllerRangeTo.dispose();
    _controllerDiscount.dispose();
    _controllerCost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double itemWidth = size.width / 2 - 24;
    double itemHeight = size.height;

    _getSupplierAdminInfo = new SupplierAdminInfoProvider(adminInfoCallBack);
    _getSupplierAdminInfo.execute();
    data != null ? _productMap = data["productDTOList"][0] : _productMap = null;
    _productMap != null
        ? _productDto = new ProductDTO.fromJson(_productMap)
        : _productDto = null;
    _productDto != null ? cost = _productDto.amount : cost = "";
    _productDto != null ? kinds = _productDto.dishDescription : kinds = "";
    _productDto != null ? rangeFrom = _productDto.minPrice : rangeFrom = "";
    _productDto != null ? rangeTo = _productDto.maxPrice : rangeTo = "";
    _productDto != null ? discount = _productDto.discount : discount = "";
    _productDto != null ? amount = _productDto.amount : amount = "";

    _updateSupplierProduct = new UpdateSupplierProductController(updateDataCallBack);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25.0),
            HeadlineWidget('עדכון מנות'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _getUpdateFoodKind(),
                  SizedBox(height: 10.0),
                  _getUpdateCost(size),
                  SizedBox(height: 10.0),
                  _getUpdateRange(size),
                  SizedBox(height: 10.0),
                  _getUpdateAmount(size),
                  SizedBox(height: 10.0),
                  _getUpdatePickUpHour(),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            _getSaveButton(),
          ],
        ),
      ),
    );
  }

  _getUpdateFoodKind() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'תיאור מנות',
          style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
        ),
        Container(
          child: TextField(
            controller: _controllerKinds,
            decoration: InputDecoration(
              hintText: kinds,
            ),
          ),
          padding: EdgeInsets.only(left: 100.0, top: 0, right: 2, bottom: 0),
          decoration: BoxDecoration(
            color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
            border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
            ],
          ),
        ),
      ],
    );
  }

  _getUpdatePickUpHour() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: Text(
            'שעות איסוף',
            style: TextStyle(color: Constants.SCREEN_DARKER_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
          ),
        ),
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ימים',
                  style: TextStyle(
                    color: Constants.SCREEN_DARKER_TEXT_COLOR,
                    fontSize: Constants.BIG_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  'א-ה',
                  style: TextStyle(
                    color: Constants.SCREEN_TEXT_COLOR,
                    fontSize: Constants.BIG_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  'שישי',
                  style: TextStyle(
                    color: Constants.SCREEN_TEXT_COLOR,
                    fontSize: Constants.BIG_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  'שבת',
                  style: TextStyle(
                    color: Constants.SCREEN_TEXT_COLOR,
                    fontSize: Constants.BIG_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Column(
              children: <Widget>[
                Text(
                  'החל',
                  style: TextStyle(
                    color: Constants.SCREEN_TEXT_COLOR,
                    fontSize: Constants.BIG_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 40.0,
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color:  Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                    border: Border.all(color:  Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            setState(() {
                              if (_startHour < 24) _startHour++;
                            });
                          },
                          child: Text('+',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                      Text(_startHour.toString() + ':00',
                        style: TextStyle(
                          color: Constants.SCREEN_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE,
                        ),
                      ),
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (_startHour > 1) _startHour--;
                              });
                            },
                            child: Text('-',
                              style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40.0,
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                    border: Border.all(color:  Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                            padding: EdgeInsets.all(0.0),
                            onPressed: () {
                              setState(() {
                                if (_fridayStartHour < 24) _fridayStartHour++;
                              });
                            },
                            child: Text('+',
                              style: TextStyle(
                                color: Constants.SCREEN_TEXT_COLOR,
                                fontSize: Constants.BIG_TEXT_SIZE,
                              ),
                            ),
                        ),
                      ),
                      Text(_fridayStartHour.toString() + ':00',
                        style: TextStyle(
                          color: Constants.SCREEN_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE,
                        ),
                      ),
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              if (_fridayStartHour > 1) _fridayStartHour--;
                            });
                          },
                          child: Text('-',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40.0,
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                    border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            setState(() {
                              if (_saturdayStartHour < 24) _saturdayStartHour++;
                            });
                          },
                          child: Text('+',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                      Text(_saturdayStartHour.toString() + ":00",
                        style: TextStyle(
                          color: Constants.SCREEN_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE,
                        ),
                      ),
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (_saturdayStartHour > 1) _saturdayStartHour--;
                              });
                            },
                            child: Text('-',
                              style: TextStyle(
                                color: Constants.SCREEN_TEXT_COLOR,
                                fontSize: Constants.BIG_TEXT_SIZE,
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Column(
              children: <Widget>[
                Text(
                  'עד',
                  style: TextStyle(
                    color: Constants.SCREEN_TEXT_COLOR,
                    fontSize: Constants.BIG_TEXT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 40.0,
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                    border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            setState(() {
                              if (_endHour < 24) _endHour++;
                            });
                          },
                          child: Text('+',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                      Text(_endHour.toString() + ":00",
                        style: TextStyle(
                          color: Constants.SCREEN_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE,
                        ),
                      ),
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            setState(() {
                              if (_endHour > 1) _endHour--;
                            });
                          },
                          child: Text('-',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40.0,
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                    border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            setState(() {
                              if (_fridayEndHour < 24) _fridayEndHour++;
                            });
                          },
                          child: Text('+',
                                    style: TextStyle(
                                    color: Constants.SCREEN_TEXT_COLOR,
                                    fontSize: Constants.BIG_TEXT_SIZE,
                                    ),
                          ),
                        ),
                      ),
                      Text(_fridayEndHour.toString() + ":00"),
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              if (_fridayEndHour > 1) _fridayEndHour--;
                            });
                          },
                          child: Text('-',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 40.0,
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                    border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            setState(() {
                              if (_saturdayEndHour < 24) _saturdayEndHour++;
                            });
                          },
                          child: Text('+',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                      Text(_saturdayEndHour.toString() + ":00",
                        style: TextStyle(
                          color: Constants.SCREEN_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE,
                        ),
                      ),
                      new ButtonTheme(
                        minWidth: 0.0,
                        padding: EdgeInsets.all(0.0),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              if (_saturdayEndHour > 1) _saturdayEndHour--;
                            });
                          },
                          child: Text('-',
                            style: TextStyle(
                              color: Constants.SCREEN_TEXT_COLOR,
                              fontSize: Constants.BIG_TEXT_SIZE,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _getUpdateCost(Size size) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'מחיר מקורי',
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
            SizedBox(width: 115),
            Text(
              'אחוז הנחה',
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 45.0,
              width: size.width / 2 - 24,
              child: TextField(
                controller: _controllerCost,
                decoration: InputDecoration.collapsed(
                  hintText: cost,
                ),
              ),
              padding:
                  EdgeInsets.only(left: 50.0, top: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                ],
              ),
            ),
            SizedBox(width: 30.0),
            Container(
              height: 45.0,
              width: size.width / 2 - 24,
              child: TextField(
                controller: _controllerDiscount,
                decoration: InputDecoration.collapsed(
                  hintText: discount + "%",
                ),
              ),
              padding:
                  EdgeInsets.only(left: 90.0, top: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _getUpdateAmount(Size size) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'כמות',
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'מנות זמינות',
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
            SizedBox(width: 114),
            Text(
              'מקסימום לאיסוף',
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 45.0,
              width: size.width / 2 - 24,
              child: TextFormField(
                controller: _controllerAmount,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                //Only numbers can be entered
                decoration: InputDecoration.collapsed(
                  hintText: amount,
                ),
              ),
              padding:
                  EdgeInsets.only(left: 50.0, top: 10, right: 10, bottom: 20),
              decoration: BoxDecoration(
                color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                ],
              ),
            ),
            SizedBox(width: 30.0),
            Container(
              height: 45.0,
              width: size.width / 2 - 24,
              child: TextField(
                controller: _controllerMaxAmountToPick,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                //Only numbers can be entered
                decoration: InputDecoration.collapsed(
                  hintText: cost,
                ),
              ),
              padding:
                  EdgeInsets.only(left: 90.0, top: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _getSaveButton() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
        ),
        ButtonTheme(
          minWidth: 325.0,
          height: 50.0,
          child: RaisedButton(
            color: Constants.BUTTON_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            onPressed: () {
              saveButtonPressed();
            },
            child: Text(
              'שמירה',
              style: TextStyle(color: Constants.BUTTON_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ),
        ),
      ],
    );
  }

  _getUpdateRange(Size size) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'טווח מחירים לפרסום',
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'החל',
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
            SizedBox(width: 160),
            Text(
              'עד',
              style: TextStyle(
                  color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              height: 45.0,
              width: size.width / 2 - 24,
              child: TextField(
                controller: _controllerRangeFrom,
                decoration: InputDecoration.collapsed(
                  hintText: rangeFrom,
                ),
              ),
              padding:
                  EdgeInsets.only(left: 50.0, top: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(3.0, 3.0)),
                ],
              ),
            ),
            SizedBox(width: 30.0),
            Container(
              height: 45.0,
              width: size.width / 2 - 24,
              child: TextField(
                controller: _controllerRangeTo,
                decoration: InputDecoration.collapsed(
                  hintText: rangeTo,
                ),
              ),
              padding:
                  EdgeInsets.only(left: 90.0, top: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(3.0, 3.0)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  saveButtonPressed() {
    if (_productDto != null) {
      _controllerPickUpFrom.text != null
          ? pickUpFrom = _controllerPickUpFrom.text
          : pickUpFrom = pickUpFrom;
      _controllerKinds.text != null
          ? _productDto.dishDescription = _controllerKinds.text
          : kinds = kinds;
      _controllerAmount.text != null
          ? _productDto.amount = _controllerAmount.text
          : amount = amount;
      _controllerRangeFrom.text != null
          ? _productDto.minPrice = _controllerRangeFrom.text
          : rangeFrom = rangeFrom;
      _controllerRangeTo.text != null
          ? _productDto.maxPrice = _controllerRangeTo.text
          : rangeTo = rangeTo;
      _controllerDiscount.text != null
          ? _productDto.discount = _controllerDiscount.text
          : discount = discount;
      _controllerCost.text != null
          ? _productDto.originalPrice = _controllerCost.text
          : cost = cost;
      _controllerMaxAmountToPick.text != null
          ? _productDto.maxNumOfDishes = _controllerMaxAmountToPick.text
          : max = max;
    } else {
      _productDto = new ProductDTO();
      pickUpFrom = _controllerPickUpFrom.text; //not in the productDTO
      _productDto.originalPrice = _controllerCost.text;
      _productDto.maxNumOfDishes = _controllerMaxAmountToPick.text;
      _productDto.discount = _controllerDiscount.text;
      _productDto.dishDescription = _controllerKinds.text;
      _productDto.amount = _controllerAmount.text;
      _productDto.minPrice = _controllerRangeFrom.text;
      _productDto.maxPrice = _controllerRangeTo.text;
    }

    jsonSupplierInfoDTO = jsonEncode(_productDto);
    _updateSupplierProduct.execute(jsonSupplierInfoDTO);
  }

  void updateDataCallBack(bool working, String msg) {
    if (working == true) {
      this.msg = "המידע עודכן!";
      showDialogMsg();
    } else {
      this.msg =
          "המידע לא עודכן עקב בעיה טכנית. אנא נסה שוב במועד מאוחר יותר. שם התקלה: " +
              msg;
      showDialogMsg();
    }
  }

  showDialogMsg() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("סטטוס: "),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('סגור'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('חזור לעמוד הקודם'),
              onPressed: () {
                Navigator.pushNamed(
                    context, SupplierHomePageScreen.SCREEN_NAME);
              },
            ),
          ],
        );
      },
    );
  }

  void adminInfoCallBack(bool working, dynamic data) {
    if (working == true) {
      setState(() {
        //show original dish details in the user interface
        this.data = data;
      });
      print("successfully load supplier data from admin/suppliers");
    } else {
      print("failed to load supplier data from admin/suppliers");
      Crashlytics.instance.log('Failed to load supplier data');
    }
  }
}
