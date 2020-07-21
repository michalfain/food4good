import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/utils/constants.dart';

class OrdersDetailsFrame extends StatelessWidget {
  final OrderDTO order;

  OrdersDetailsFrame(this.order);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding:
                EdgeInsets.only(left: 50.0, top: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Constants.ORDER_FRAME_COLOR,
              border: Border.all(color: Constants.ORDER_FRAME_BORDER_COLOR),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Constants.ORDER_FRAME_SHADOW_COLOR,
                    offset: Offset(3.0, 3.0)),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: (order.status == 1)
                          ? Constants.ORDER_STATUS_1
                          : (order.status == 2)
                              ? Constants.ORDER_STATUS_2
                              : Constants.ORDER_STATUS_3,
                    ),
                  ],
                ),
                SizedBox(width: 13.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      order.userId.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                    Text(
                      'UID',
                      style: TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                  ],
                ),
                SizedBox(width: 13.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      order.createdAt,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                    Text(
                      'תאריך',
                      style: TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                  ],
                ),
                SizedBox(width: 13.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      order.numOfProducts.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                    Text(
                      'נקנו',
                      style: TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                  ],
                ),
                SizedBox(width: 13.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      order.totalPrice.toString() + ' ש"ח',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                    Text(
                      'סך תשלום',
                      style: TextStyle(fontSize: Constants.MEDIUM_TEXT_SIZE),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
