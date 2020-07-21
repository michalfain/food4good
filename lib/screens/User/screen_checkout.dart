import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/orders_provider.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/screens/user/screen_order_confirmation.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const String SCREEN_NAME = 'CheckoutScreen';

  final SupplierInfoDTO supplierInfo;
  final OrderDTO order;

  CheckoutScreen({Key key, this.supplierInfo, this.order}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckoutScreenState();
  }
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Container _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100.0,
                width: 10.0,
              ),
              CircleAvatar(
                backgroundColor: Constants.CIRCLE_AVATAR_RADIUS_CHECKOUT_COLOR,
                radius: Constants.CIRCLE_AVATAR_RADIUS_CHECKOUT_SCREEN,
                child: ClipOval(
                  child: CachedNetworkImage(
                    placeholder: (context, restId) => _getPlaceHolderLogo(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    imageUrl: widget.supplierInfo.logoImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                '${widget.supplierInfo.restName}',
                style: TextStyle(fontSize: Constants.CHECKOUT_SCREEN_REST_NAME),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            color: Constants.CHECKOUT_SCREEN_CONTAINER_UNDERLINE,
            height: 3.0,
            width: 580.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          _getDish(),
          SizedBox(
            height: 20.0,
          ),
          _getPayment(),
          SizedBox(
            height: 30.0,
          ),
          _getPickupTime(),
          SizedBox(
            height: 30.0,
          ),
          _getAddress(),
          SizedBox(
            height: 20.0,
          ),
          Text(
            Translations.of(context).getString(Strings.finalPriceWillBeSetByTheSupplier),
            style: TextStyle(fontSize: Constants.CHECKOUT_SCREEN_TEXT_FONT, color: Constants.SCREEN_TEXT_COLOR),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(),
          ),
          _buildConfirmationButton(),
        ],
      ),
    );
  }

  _buildConfirmationButton() {
    return ButtonTheme(
      minWidth: 375.0,
      height: 50.0,
      child: RaisedButton(
        color: Constants.BUTTON_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        onPressed: () {
          placeOrder();
        },
        child: Text(
          Translations.of(context).getString(Strings.confirmOrderButton),
          style: TextStyle(color: Constants.BUTTON_TEXT_COLOR, fontSize: Constants.CHECKOUT_SCREEN_BUTTON_FONT),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        Translations.of(context).getString(Strings.yourOrder),
        style: TextStyle(fontSize: Constants.SCREEN_APPBAR_FONT, color: Constants.SCREEN_APPBAR_COLOR),
      ),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.grey),
    );
  }

  void placeOrder() {
    OrderProvider orderProvider = new OrderProvider(widget.order, orderSubmitCallBack);
    orderProvider.execute();
  }

  void orderSubmitCallBack(OrderDTO order) {
    if (order != null) {
      var dataModel = Provider.of<DataModel>(context, listen: false);
      dataModel.loadOrders();

      var route2 = new MaterialPageRoute(
        builder: (BuildContext context) => OrderConfirmationScreen(
          supplierInfoDTO: widget.supplierInfo,
          orders: order,
        ),
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(route2);
    } else {
      Crashlytics.instance.log("error in place order");
    }
  }

  _getDish() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 50.0),
        ),
        Icon(
          Icons.fastfood,
          size: Constants.SCREEN_ICON_SIZE,
          color: Constants.CHECKOUT_SCREEN_ICON_COLOR,
        ),
        Column(
          children: <Widget>[
            Text(
              Translations.of(context).getString(Strings.selectedItem),
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.CHECKOUT_SCREEN_TEXT_FONT),
            ),
            SizedBox(
              width: 250.0,
            ),
            Text(
              '${widget.order.numOfProducts} X ${widget.supplierInfo.productName}',
              style:
                  TextStyle(color: Constants.CHECKOUT_SCREEN_VAR_COLOR, fontSize: Constants.CHECKOUT_SCREEN_VAR_FONT),
            ),
          ],
        ),
      ],
    );
  }

  _getPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 50.0),
        ),
        Icon(
          Icons.attach_money,
          size: Constants.SCREEN_ICON_SIZE,
          color: Constants.CHECKOUT_SCREEN_ICON_COLOR,
        ),
        Column(
          children: <Widget>[
            Text(
              Translations.of(context).getString(Strings.estimatedPayment),
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.CHECKOUT_SCREEN_TEXT_FONT),
            ),
            SizedBox(
              width: 250.0,
            ),
            Text(
              '${widget.order.totalPrice}',
              style:
                  TextStyle(color: Constants.CHECKOUT_SCREEN_VAR_COLOR, fontSize: Constants.CHECKOUT_SCREEN_VAR_FONT),
            ),
          ],
        ),
      ],
    );
  }

  _getPickupTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 50.0),
        ),
        Icon(
          Icons.timer,
          size: Constants.SCREEN_ICON_SIZE,
          color: Constants.CHECKOUT_SCREEN_ICON_COLOR,
        ),
        Column(
          children: <Widget>[
            Text(
              Translations.of(context).getString(Strings.pickupTime),
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.CHECKOUT_SCREEN_TEXT_FONT),
            ),
            SizedBox(
              width: 250.0,
            ),
            Text(
              widget.supplierInfo.pickupHour != ""
                  ? widget.supplierInfo.pickupHour
                  : Translations.of(context).getString(Strings.close),
              style:
                  TextStyle(color: Constants.CHECKOUT_SCREEN_VAR_COLOR, fontSize: Constants.CHECKOUT_SCREEN_VAR_FONT),
            ),
          ],
        ),
      ],
    );
  }

  _getAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 50.0),
        ),
        Icon(Icons.account_balance, size: Constants.SCREEN_ICON_SIZE, color: Constants.CHECKOUT_SCREEN_ICON_COLOR),
        Column(
          children: <Widget>[
            Text(
              Translations.of(context).getString(Strings.address),
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.CHECKOUT_SCREEN_TEXT_FONT),
            ),
            SizedBox(
              width: 250.0,
            ),
            Text(
              '${widget.supplierInfo.address}',
              style:
                  TextStyle(color: Constants.CHECKOUT_SCREEN_VAR_COLOR, fontSize: Constants.CHECKOUT_SCREEN_VAR_FONT),
            ),
          ],
        ),
      ],
    );
  }

  _getPlaceHolderLogo() {
    return Image(image: AssetImage('assets/images/logo.jpg'));
  }
}
