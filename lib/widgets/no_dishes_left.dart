import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';

class NoDishesLeft extends StatefulWidget {
  final SupplierInfoDTO _supplierInfoDTO;

  NoDishesLeft(this._supplierInfoDTO);

  @override
  _NoDishesLeftState createState() => _NoDishesLeftState();
}

class _NoDishesLeftState extends State<NoDishesLeft> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _itemWidth = size.width - 8;
    double _itemHeight = size.height / 4;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _getNoDishesLeft(context, _itemWidth, _itemHeight),
        ],
      ),
    );
  }
}

_getNoDishesLeft(BuildContext context, _itemWidth, _itemHeight) {
  return Container(
    color: Colors.black54,
    width: _itemWidth,
    height: _itemHeight / 2,
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 5.0,
        ),
        Text(
          Translations.of(context).getString(Strings.privacyPolicy),
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        SizedBox(
          height: 8.0,
        ),
        Icon(
          Icons.local_florist,
          color: Colors.white,
        ),
      ],
    ),
  );
}
