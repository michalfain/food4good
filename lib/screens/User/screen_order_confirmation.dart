import 'package:flutter/material.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:provider/provider.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final SupplierInfoDTO supplierInfoDTO;
  final OrderDTO orders;
  static const String SCREEN_NAME = 'OrderConfirmationScreen';

  OrderConfirmationScreen({Key key, this.supplierInfoDTO, this.orders})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrderConfirmationScreen();
  }
}

class _OrderConfirmationScreen extends State<OrderConfirmationScreen> {
  double textSize;

  @override
  void initState() {
    super.initState();
    textSize = 100.00;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                _buildOrderConfirmationDetailsUpperText(context),
                SizedBox(height: (15.0)),
                _buildButtonMyOrders(context),
                SizedBox(height: (45.0)),
                Expanded(
                  child: Container(),
                ),
                _buildJoinUsBottomText(context),
                SizedBox(
                  height: 15.0,
                ),
                _buildButtonCheckOtherSuppliers(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderConfirmationDetailsUpperText(BuildContext context) {
    return Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: (45.0)),
        Text(
          Translations.of(context).getString(Strings.orderIsDone),
          style: TextStyle(
              fontSize:
              Constants.ORDER_CONFIRMATION_SCREEN_CONFIRM_FONT,
              color:
              Constants.ORDER_CONFIRMATION_SCREEN_TEXT_COLOR),
        ),
        SizedBox(height: (15.0)),
        Text(
            "${Translations.of(context).getString(Strings.yourOrderWillWaitAt)} ${widget.supplierInfoDTO.restName}",
            style: TextStyle(
                fontSize: Constants.BIG_TEXT_SIZE,
                color: Constants.SCREEN_TEXT_COLOR)),
        Text(
            "${Translations.of(context).getString(Strings.duringPickupHours)} ${widget.supplierInfoDTO.pickupHour}",
            style: TextStyle(
                fontSize: Constants.BIG_TEXT_SIZE,
                color: Constants.SCREEN_TEXT_COLOR)),
        SizedBox(height: (15.0)),
        Icon(
          Icons.local_florist,
          size: Constants.SCREEN_ICON_SIZE,
          color: Constants.ORDER_CONFIRMATION_SCREEN_ICON_COLOR,
        ),
        SizedBox(height: (15.0)),
        Text(
          Translations.of(context)
              .getString(Strings.uponPickupPresentOrderScreen),
          style: TextStyle(
              fontSize: Constants.BIG_TEXT_SIZE,
              color: Constants.SCREEN_TEXT_COLOR),
        ),
        Text(
            Translations.of(context)
                .getString(Strings.andConfirmWithSupplier),
            style: TextStyle(
                fontSize: Constants.BIG_TEXT_SIZE,
                color: Constants.SCREEN_TEXT_COLOR)),
      ],
    );
  }

  Widget _buildJoinUsBottomText(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          Translations.of(context).getString(Strings.joinUs),
          style: TextStyle(
              fontSize: Constants.MEDIUM_TEXT_SIZE,
              color: Constants.SCREEN_TEXT_COLOR),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Translations.of(context).getString(Strings.thankYou),
              style: TextStyle(
                  fontSize: Constants.MEDIUM_TEXT_SIZE,
                  color: Constants.SCREEN_TEXT_COLOR),
            ),
            Icon(
              Icons.favorite,
              size: Constants.HEART_ICON_SIZE,
              color: Constants.HEART_ICON_COLOR_GREY,
            ),
          ],
        ),
      ],
    );
  }

  ButtonTheme _buildButtonCheckOtherSuppliers(BuildContext context) {
    return ButtonTheme(
      minWidth: 345.0,
      height: 50.0,
      child: RaisedButton(
        color: Constants.BUTTON_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Text(
          Translations.of(context)
              .getString(Strings.checkOutOtherSuppliers),
          style: TextStyle(
              color: Constants
                  .RAISED_BUTTON_CONFIRMATION_ORDER_TEXT_COLOR,
              fontSize: Constants.TEXT_RAISED_BUTTON_SIZE),
        ),
        onPressed: () {
          var dataModel =
          Provider.of<DataModel>(context, listen: false);
//                      var route2 = new MaterialPageRoute(
//                        builder: (BuildContext context) => new MainScreen(),
//                      );
//                      Navigator.of(context).push(route2);
          dataModel.tabIndex = 0;
          Navigator.of(context).pop();
        },
      ),
    );
  }

  ButtonTheme _buildButtonMyOrders(BuildContext context) {
    return ButtonTheme(
      minWidth: 200.0,
      height: 50.0,
      child: RaisedButton(
        color: Constants.RAISED_BUTTON_CONFIRM_ORDER_BG_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Text(
          Translations.of(context).getString(Strings.myOrders),
          style: TextStyle(
              color: Constants
                  .RAISED_BUTTON_CONFIRMATION_ORDER_TEXT_COLOR,
              fontSize: Constants.TEXT_RAISED_BUTTON_SIZE),
        ),
        onPressed: () {
          var dataModel =
          Provider.of<DataModel>(context, listen: false);
          dataModel.tabIndex = 1;
          Navigator.of(context).pop();
//                      var route2 = new MaterialPageRoute(
//                        builder: (BuildContext context) => new OrdersScreen(
//                          supplierInfoDTO: widget.supplierInfoDTO,
//                          orders: widget.orders,
//                        ),
//                      );
//                      Navigator.of(context).push(route2);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        title: Text(
          Translations.of(context).getString(Strings.orderConfirmation),
          style: TextStyle(
              fontSize: Constants.SCREEN_APPBAR_FONT,
              color: Constants.SCREEN_APPBAR_COLOR),
        ),
        backgroundColor: Constants.APPBAR_BG_COLOR_SCREEN,
        iconTheme: new IconThemeData(color: Colors.grey));
  }
}
