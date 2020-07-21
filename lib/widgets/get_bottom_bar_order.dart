import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/favorite_controller.dart';
import 'package:food4good_app/dto/upper_bar_config.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/widgets/widget_locations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget_like.dart';

class GetBottomBarOrder extends StatefulWidget {
  final SupplierInfoDTO _supplierInfoDTO;

  GetBottomBarOrder(this._supplierInfoDTO);

  @override
  _GetBottomBarOrderState createState() => _GetBottomBarOrderState();
}

class _GetBottomBarOrderState extends State<GetBottomBarOrder> {
  UpperBarConfig _upperBarConfig =
      new UpperBarConfig(false, true, true, true, true, false, false, false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: <Widget>[
          _getLocationWidget(),
          Expanded(child: Container()),
          _getLikes(),
        ],
      ),
    );
  }

  _getLikes() {
    if (_upperBarConfig.isLikesShow || _upperBarConfig.isHeartShow)
      return WidgetLike(widget._supplierInfoDTO, _upperBarConfig,
          Constants.DISH_ORDER_SCREEN_NUM_OF_LIKES_COLOR);
    else {
      return SizedBox();
    }
  }

  _getLocationWidget() {
    return WidgetLocation(
      widget._supplierInfoDTO,
      Constants.DISH_ORDER_SCREEN_LOCATION_COLOR,
    );
  }
}
