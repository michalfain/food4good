import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/screens/user/screen_dish_order.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';

class GetInfo extends StatefulWidget {
//  String units;
//  String priceRange;
//  String timeToPick;
  final bool isTextShow;
  final SupplierInfoDTO _supplierInfoDTO;

  GetInfo(this._supplierInfoDTO, this.isTextShow);

  @override
  _GetInfoState createState() => _GetInfoState();
}

class _GetInfoState extends State<GetInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildItemsCountWidget(context),
          _buildPriceRangeWidget(context),
          _buildPickUpTimeWidget(context)
        ],
      ),
    );
  }

  Widget _buildPickUpTimeWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.timer,
              size: Constants.GET_INFO_TEXT_SIZE,
              color: Constants.GET_INFO_ITEM_COLOR,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              widget._supplierInfoDTO.pickupHour != ""
                  ? widget._supplierInfoDTO.pickupHour
                  : Translations.of(context).getString(Strings.close),
              style: TextStyle(
                  fontSize: Constants.GET_INFO_TEXT_SIZE,
                  color: Constants.GET_INFO_ITEM_COLOR),
            ),
          ],
        ),
        widget.isTextShow
            ? Row(
                children: <Widget>[
                  SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    Translations.of(context).getString(Strings.pickupTime),
                    style: TextStyle(color: Constants.GET_INFO_ITEM_COLOR),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }

  Widget _buildPriceRangeWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.shekelSign,
              size: Constants.GET_INFO_ICON_SIZE_SMALL,
              color: Constants.GET_INFO_ITEM_COLOR,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              widget._supplierInfoDTO.range,
              style: TextStyle(
                  fontSize: Constants.GET_INFO_TEXT_SIZE,
                  color: Constants.GET_INFO_ITEM_COLOR),
            ),
          ],
        ),
        widget.isTextShow
            ? Row(
                children: <Widget>[
                  SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    Translations.of(context).getString(Strings.priceRange),
                    style: TextStyle(color: Constants.GET_INFO_ITEM_COLOR),
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }

  Widget _buildItemsCountWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.fastfood,
              size: Constants.GET_INFO_ICON_SIZE,
              color: Constants.GET_INFO_ITEM_COLOR,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              widget._supplierInfoDTO.numOfDishes,
              style: TextStyle(
                  fontSize: Constants.GET_INFO_TEXT_SIZE,
                  color: Constants.GET_INFO_ITEM_COLOR),
            )
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 3.0,
            ),
            widget.isTextShow
                ? Text(
                    Translations.of(context).getString(Strings.items),
                    style: TextStyle(color: Constants.GET_INFO_ITEM_COLOR),
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }
}
