import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/constants.dart';

import 'widget_discount.dart';

class BGImageWidget extends StatefulWidget {
  final SupplierInfoDTO _supplierInfoDTO;

  BGImageWidget(this._supplierInfoDTO);

  @override
  _BGImageWidgetState createState() => _BGImageWidgetState();
}

class _BGImageWidgetState extends State<BGImageWidget> {
  String restId;

  @override
  Widget build(BuildContext context) {
    restId = widget._supplierInfoDTO.restId;
    Size size = MediaQuery.of(context).size;
    double _itemWidth = size.width - 8;
    double _itemHeight = size.height / 5;
    double _discountWidth = size.width - 8;
    double _discountHeight = size.height / 5;

    Widget item = Card(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _getBackGround(_itemHeight, _itemWidth),
              DiscountWidget(widget._supplierInfoDTO.discount, _discountHeight,
                  _discountWidth),
              _getLogo(_itemHeight, _itemWidth)
            ],
          ),
          //  _getBottomBar(_itemWidth),
        ],
      ),
    );
    return item;
  }

  _getLogo(_itemHeight, _itemWidth) {
    String logoUrl = Constants.LOGO_URL +
        widget._supplierInfoDTO.restId.toString() +
        "_logo.jpg";
    print(logoUrl);
    return Padding(
      padding: EdgeInsets.fromLTRB(_itemWidth / 3, _itemHeight / 2, 10, 0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: _itemHeight / 5.5 + 3,
          child: ClipOval(
            child: CachedNetworkImage(
              placeholder: (context, restId) => _getPlaceHolderLogo(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              imageUrl: logoUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  _getBackGround(_itemHeight, _itemWidth) {
    String url = Constants.LOGO_URL +
        widget._supplierInfoDTO.restId.toString() +
        "_bg.jpg";
    return CachedNetworkImage(
      placeholder: (context, restId) =>
          _getPlaceHolderBackGround(_itemWidth, _itemHeight),
      imageUrl: url,
      width: _itemWidth,
      height: _itemHeight,
      fit: BoxFit.fill,
      alignment: Alignment.center,
    );
  }

  _getPlaceHolderBackGround(double _itemWidth, double _itemHeight) {
    return Image(
        image: AssetImage(Constants.IMG_BACKGROUND),
        width: _itemWidth,
        height: _itemHeight,
        fit: BoxFit.fill,
        alignment: Alignment.center);
  }

  _getPlaceHolderLogo() {
    return Image(image: AssetImage('assets/images/logo.jpg'));
  }
}
