import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:provider/provider.dart';

class ClosedOrderItem extends StatefulWidget {
  final OrderDTO order;

  ClosedOrderItem(this.order);

  @override
  _ClosedOrderItemState createState() => _ClosedOrderItemState();
}

class _ClosedOrderItemState extends State<ClosedOrderItem> {
  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context, listen: true);

    var supplierInfo = dataModel.supplierItemsMap[widget.order.supplierId.toString()];
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Constants.CIRCLE_AVATAR_RADIUS_CHECKOUT_COLOR,
                      radius: Constants.CIRCLE_AVATAR_RADIUS_CHECKOUT_SCREEN,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                          imageUrl: supplierInfo.logoImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            widget.order.supplierName,
                            style: TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_COLOR),
                          ),
                          Text(
                              widget.order.numOfProducts.toString() +
                                  " " +
                                  Translations.of(context).getString(Strings.dishes),
                              style: TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_COLOR)),
                        ],
                      ),
                    )
                  ],
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Constants.ORDER_ITEM_FLAT_BUTTON_COLOR),
                  ),
                  child: Text(widget.order.createdAt.substring(0, 9),
                      style: TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_COLOR)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: <Widget>[
                  Text(Translations.of(context).getString(Strings.finalPrice),
                      style: TextStyle(
                          fontSize: Constants.ORDER_ITEM_FIELD_FONT, color: Constants.ORDER_ITEM_CONST_COLOR)),
                  Text(widget.order.totalPrice,
                      style: TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_CONST_COLOR)),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(Translations.of(context).getString(Strings.pickupTime),
                      style: TextStyle(
                          fontSize: Constants.ORDER_ITEM_FIELD_FONT, color: Constants.ORDER_ITEM_CONST_COLOR)),
                  Text(supplierInfo.pickupHour,
                      style: TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_COLOR)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
