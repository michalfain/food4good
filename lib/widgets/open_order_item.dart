import 'package:flutter/material.dart';
import 'package:food4good_app/screens/user/screen_pickup_order.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OpenOrderItem extends StatefulWidget {
  final OrderDTO order;

  OpenOrderItem(this.order);

  @override
  _OpenOrderItemState createState() => _OpenOrderItemState();
}

class _OpenOrderItemState extends State<OpenOrderItem> {
  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context, listen: true);

    var supplierInfo = dataModel.supplierItemsMap[widget.order.supplierId.toString()];
    return InkWell(
      onTap: () {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new PickupOrderScreen(widget.order, false),
        );
        Navigator.of(context).push(route);
      },
      child: Card(
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
                                style:
                                    TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_COLOR)),
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
                    child: Text(widget.order.updatedAt.substring(0, 11),
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
                    Text(Translations.of(context).getString(Strings.estimatedPayment),
                        style: TextStyle(
                            fontSize: Constants.ORDER_ITEM_FIELD_FONT, color: Constants.ORDER_ITEM_CONST_COLOR)),
                    Text(widget.order.totalPrice,
                        style: TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_COLOR)),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(Translations.of(context).getString(Strings.pickupTime),
                        style: TextStyle(
                            fontSize: Constants.ORDER_ITEM_FIELD_FONT, color: Constants.ORDER_ITEM_CONST_COLOR)),
                    Text(
                        widget.order.pickUpTime != null
                            ? widget.order.pickUpTime
                            : Translations.of(context).getString(
                                Strings.close), //TODO: Yasmin: check if pick_up_time is always null at Back End
                        style: TextStyle(fontSize: Constants.ORDER_ITEM_FONT, color: Constants.ORDER_ITEM_COLOR)),
//                Text(widget._supplierInfoDTO.pickupHour, style: TextStyle(fontSize: 20.0, color: Colors.grey[600])),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
