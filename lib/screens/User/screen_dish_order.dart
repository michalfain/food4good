import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/dto/upper_bar_config.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/widgets/get_bottom_bar_order.dart';
import 'package:food4good_app/widgets/widget_rest_info.dart';
import 'package:food4good_app/widgets/main_logo_widget.dart';
import 'package:food4good_app/widgets/upper_bar.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:sprintf/sprintf.dart';
import 'screen_checkout.dart';

class DishOrderScreen extends StatefulWidget {
  final SupplierInfoDTO supplierInfoDTO;
  UpperBarConfig _upperBarConfig =
  new UpperBarConfig(false, true, false, true, false, false, false, false);

  static const String SCREEN_NAME = 'DishOrderScreen';

  DishOrderScreen({Key key, this.supplierInfoDTO}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DishOrderScreen();
  }
}

class _DishOrderScreen extends State<DishOrderScreen> {
  int numOfDishesOrder = 0;
  double totalCost = 0;
  OrderDTO order;
  int _from = 0;
  int _to = 0;
  int _fix = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildScrollablePartOfTheScreen(context),
            ),
            _buildBottomPurchaseWidget(),
          ],
        ),
      ),
    );
  }

  Column _buildBottomPurchaseWidget() {
    return Column(
//            mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(height: (10.0)),
        _buildNumberOfItemsPicker(),
        SizedBox(height: (10.0)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _getPressToOrder(),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  SingleChildScrollView _buildScrollablePartOfTheScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          UpperBar(widget.supplierInfoDTO, widget._upperBarConfig),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GetBottomBarOrder(widget.supplierInfoDTO),
                SizedBox(height: 10.0),
                _getPossibleToPurchaseText(context),
                GetInfo(widget.supplierInfoDTO, true),
                SizedBox(height: (10.0)),
                Text(
                  Translations.of(context)
                      .getString(Strings.selectHowManyItemsToSave),
                  style: TextStyle(
                      fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE2_FONT,
                      color: Constants.DISH_ORDER_SCREEN_HEADLINE2_COLOR),
                ),
                Text(
                  Translations.of(context)
                      .getString(Strings.thePaymentWillBeHandledBySupplier),
                  style: TextStyle(
                      fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE2_FONT,
                      color: Constants.DISH_ORDER_SCREEN_HEADLINE2_COLOR),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPossibleToPurchaseText(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          Translations.of(context).getString(Strings.possibleToPurchase),
          style: TextStyle(
              fontFamily: 'Rubik',
              fontStyle: FontStyle.normal,
              fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE_FONT,
              color: Constants.DISH_ORDER_SCREEN_HEADLINE_COLOR),
        ),
        Text(
          widget.supplierInfoDTO.description,
          style: TextStyle(
              fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE_FONT,
              color: Constants.DISH_ORDER_SCREEN_HEADLINE_COLOR),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    if (widget.supplierInfoDTO != null &&
        widget.supplierInfoDTO.restName != null &&
        widget.supplierInfoDTO.restName.isNotEmpty) {
      return AppBar(
        title: Text(
          widget.supplierInfoDTO.restName,
          style: TextStyle(
              fontSize: Constants.SCREEN_APPBAR_FONT,
              color: Constants.SCREEN_APPBAR_COLOR),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.grey),
      );
    } else {
      return AppBar(
        centerTitle: true,
        title: MainLogoWidget(),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.grey),
      );
    }
  }

  _getPressToOrder() {
    return SizedBox(
      width: double.infinity,
      child: ButtonTheme(
        minWidth: 345.0,
        height: 50.0,
        buttonColor: Constants.BUTTON_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        textTheme: ButtonTextTheme.primary,
        ///////////// what about that??????
        child: RaisedButton(
          onPressed: () {
            setOrderData();
            var route2 = new MaterialPageRoute(
              builder: (BuildContext context) => new CheckoutScreen(
                supplierInfo: widget.supplierInfoDTO,
                order: order,
              ),
            );
            if (numOfDishesOrder > 0) Navigator.of(context).push(route2);
          },
          child: Text(
            Translations.of(context).getString(Strings.orderButton),
            style: TextStyle(
                fontSize: Constants.TEXT_BUTTON_SIZE,
                color: Constants.BUTTON_TEXT_COLOR),
          ),
        ),
      ),
    );
  }

  _buildNumberOfItemsPicker() {
    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Translations.of(context)
                  .getString(Strings.toOrderPleaseSelectNoOfItems),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE2_FONT),
            ),
            Text(
                Translations.of(context)
                    .getString(Strings.youCanSelectUpToThreeItems),
                style: TextStyle(
                    fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE3_FONT)),
          ],
        ),
        SizedBox(height: (10.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ButtonTheme(
                minWidth: 40,
                height: 40,
                child: RaisedButton(
                  color: Constants.RAISED_BUTTON_DISH_ORDER_COLOR,
                  textColor: Constants.RAISED_BUTTON_DISH_ORDER_TEXT_COLOR,
                  disabledColor:
                  Constants.RAISED_BUTTON_DISH_ORDER_DISABLE_COLOR,
                  disabledTextColor:
                  Constants.RAISED_BUTTON_DISH_ORDER_TEXT_COLOR,
                  padding: EdgeInsets.all(1.0),
                  splashColor: Constants.RAISED_BUTTON_DISH_ORDER_SPLASH_COLOR,
                  onPressed: () {
                    setState(() {
                      if (numOfDishesOrder == 3)
                        numOfDishesOrder = 3;
                      else
                        numOfDishesOrder = numOfDishesOrder + 1;
                      _setPriceRange();
                    });
                  },
                  child: Text(
                    "+",
                    style: TextStyle(
                        fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE_FONT),
                  ),
                ),
              ),
            ),
            SizedBox(width: (8.0)),
            Text(
              numOfDishesOrder.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: (8.0)),
            Container(
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                //     color: Colors.white,
                //   border: Border.all(color: Colors.black),
              ),
              child: ButtonTheme(
                minWidth: 40,
                height: 40,
                child: RaisedButton(
                  color: Constants.RAISED_BUTTON_DISH_ORDER_COLOR,
                  textColor: Constants.RAISED_BUTTON_DISH_ORDER_TEXT_COLOR,
                  disabledColor:
                  Constants.RAISED_BUTTON_DISH_ORDER_DISABLE_COLOR,
                  disabledTextColor:
                  Constants.RAISED_BUTTON_DISH_ORDER_TEXT_COLOR,
                  padding: EdgeInsets.all(1.0),
                  splashColor: Constants.RAISED_BUTTON_DISH_ORDER_SPLASH_COLOR,
                  // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (numOfDishesOrder == 0)
                        numOfDishesOrder = 0;
                      else
                        numOfDishesOrder = numOfDishesOrder - 1;
                      _setPriceRange();
                    });
                  },
                  child: Text(
                    "-",
                    style: TextStyle(
                        fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE_FONT),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: (3.0)),
        _to > 0
            ? Text(
          sprintf(
              Translations.of(context)
                  .getString(Strings.estimatedPayment2Parameters),
              [_from, _to]),
          style: TextStyle(
              fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE2_FONT),
        )
            : Text(
          sprintf(
              Translations.of(context)
                  .getString(Strings.estimatedPayment1Parameter),
              [_fix]),
          style: TextStyle(
              fontSize: Constants.DISH_ORDER_SCREEN_HEADLINE2_FONT),
        ),
      ],
    );
  }

  void _setPriceRange() {
    _from = (double.parse(widget.supplierInfoDTO.rangeFrom) * numOfDishesOrder)
        .round();
    _to = (double.parse(widget.supplierInfoDTO.rangeTo) * numOfDishesOrder)
        .round();
    _fix =
        (double.parse(widget.supplierInfoDTO.cost) * numOfDishesOrder).round();
  }

  void setOrderData() {
    var totalCost =
        double.parse(widget.supplierInfoDTO.cost) * numOfDishesOrder;

    order = OrderDTO(
        supplierId: int.parse(widget.supplierInfoDTO.restId),
        numOfProducts: numOfDishesOrder,
        totalPrice: totalCost.toString(),
        pickUpAddress: widget.supplierInfoDTO.address,
        productId: widget.supplierInfoDTO.productId,
        pickupTime: widget.supplierInfoDTO.pickupHour);
  }
}
