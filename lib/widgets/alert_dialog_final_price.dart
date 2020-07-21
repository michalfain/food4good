import 'package:flutter/material.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/screens/user/screen_pickup_order.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:provider/provider.dart';

class PriceAlert extends StatefulWidget {
  final OrderDTO order;

  PriceAlert(this.order);
  @override
  _PriceAlertState createState() => _PriceAlertState();
}

class _PriceAlertState extends State<PriceAlert> {
  final String TAG = "PriceAlert";
  final priceController = TextEditingController();
  final dishesController = TextEditingController();
  int finalPrice;
  int finalDishes;

  @override
  void dispose() {
    priceController.dispose();
    dishesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context, listen: true);
    var supplierInfo = dataModel.supplierItemsMap[widget.order.supplierId.toString()];

    return AlertDialog(
      actionsPadding: EdgeInsets.all(15.0),
      title: Center(
        child: Text(
          Translations.of(context).getString(Strings.finalPrice),
          style: TextStyle(
            color: Constants.ALERT_DIALOG_FONT_COLOR,
          ),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Translations.of(context).getString(Strings.pleaseAddFinalPrice),
            style: TextStyle(
              color: Constants.ALERT_DIALOG_FONT_COLOR,
            ),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Text(
            Translations.of(context).getString(Strings.pleaseAddFinalNumOfDishes),
            style: TextStyle(
              color: Constants.ALERT_DIALOG_FONT_COLOR,
            ),
          ),
          TextField(
            controller: dishesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            Translations.of(context).getString(
              Strings.finalPriceWillBeAddedBySupplier,
            ),
            style: TextStyle(
              fontSize: Constants.ALERT_DIALOG_SMALL_FONT,
              color: Constants.ALERT_DIALOG_FONT_COLOR,
            ),
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: 300.0,
          height: 45.0,
          child: RaisedButton(
            color: Constants.BUTTON_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            onPressed: () {
              var finalPriceString = priceController.text;
              var finalDishString = dishesController.text;
              finalDishes = int.parse(finalDishString);
              finalPrice = int.parse(finalPriceString);
              widget.order.numOfProducts = finalDishes;
              widget.order.totalPrice = finalPrice.toString();
              Navigator.of(context).pop();
              var route = new MaterialPageRoute(
                builder: (BuildContext context) => new PickupOrderScreen(widget.order, true),
              );
              Navigator.of(context).push(route);
            },
            child: Text(
              Translations.of(context).getString(Strings.confirm),
              style: TextStyle(color: Constants.BUTTON_TEXT_COLOR),
            ),
          ),
        ),
      ],
    );
  }
}
