import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/enum_order_status.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/screens/screen_main/page_orders.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:provider/provider.dart';

class CancelOrderDialog extends StatefulWidget {
  final OrderDTO order;

  CancelOrderDialog(this.order);
  @override
  _CancelOrderDialogState createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  final String TAG = "CancelOrderDialog";

  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context, listen: true);
    var supplierInfo = dataModel.supplierItemsMap[widget.order.supplierId.toString()];

    return AlertDialog(
      actionsPadding: EdgeInsets.all(15.0),
      title: Center(
        child: Text(
          Translations.of(context).getString(Strings.doYouWantToCancelOrder),
          style: TextStyle(
            color: Constants.ALERT_DIALOG_FONT_COLOR,
          ),
        ),
      ),
      actions: [
        SizedBox(
            width: 300.0,
            height: 45.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Constants.BUTTON_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.order.status = OrderStatus.canceled;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Translations.of(context).getString(Strings.yes),
                    style: TextStyle(color: Constants.BUTTON_TEXT_COLOR),
                  ),
                ),
                RaisedButton(
                  color: Constants.BUTTON_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Translations.of(context).getString(Strings.no),
                    style: TextStyle(color: Constants.BUTTON_TEXT_COLOR),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
