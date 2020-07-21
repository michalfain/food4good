import 'package:flutter/material.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';

import 'draw_right_triangle.dart';
import 'draw_triangle.dart';

class DiscountWidget extends StatefulWidget {
  String _discount;
  double _itemHeight;
  double _itemWidth;

  DiscountWidget(this._discount, this._itemHeight, this._itemWidth);

  @override
  _DiscountWidgetState createState() => _DiscountWidgetState();
}

class _DiscountWidgetState extends State<DiscountWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: widget._itemHeight / 2.5,
            width: 40,
            child: Container(
              color: Constants.FLAG_COLOR,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: Text(widget._discount,
                        style: TextStyle(color: Constants.DISCOUNT_TEXT_COLOR)),
                  ),
                  Text(Translations.of(context).getString(Strings.discount),
                      style: TextStyle(color: Constants.DISCOUNT_TEXT_COLOR)),
                ],
              ),
              //child: _getTextDiscount(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0.0, 49.0, 16.0, 0.0),
            child: CustomPaint(size: Size(24, 24), painter: DrawTriangle()),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10.0, 43.0, 0.0, 0.0),
            child:
                CustomPaint(size: Size(30, 30), painter: DrawRightTriangle()),
          ),
        ),
      ],
    );
  }
}
