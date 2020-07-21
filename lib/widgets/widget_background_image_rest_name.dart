import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class BGImageRestNameWidget extends StatefulWidget {
//  final SupplierInfoDTO supplierInfoDTO;
final dynamic data;

  BGImageRestNameWidget(
    this.data);

  @override
  _BGImageRestNameWidgetState createState() => _BGImageRestNameWidgetState();
}

class _BGImageRestNameWidgetState extends State<BGImageRestNameWidget> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _itemWidth = size.width - 8;
    double _itemHeight = size.height / 5;

    Widget item = Stack(
      children: <Widget>[
        widget.data!=null? _getBackGround(_itemHeight, _itemWidth): '',
        //_getRestName(),
        widget.data!=null? _getLogo(_itemHeight, _itemWidth): '',
      ],
    );

    return item;
  }

//  _getRestName() {
//    return Row(
//      children: <Widget>[
//        SizedBox(
//          height: 160.0,
//          width: 10.0,
//        ),
//        Text(widget.data!=null? '${widget.data['supplierName']}': 'שם המסעדה',
//            style: TextStyle(
//              fontSize: 20.0,
//              color: Colors.white,
//            )),
//      ],
//    );
//  }

  _getPlaceHolderBackGround(double _itemWidth, double _itemHeight) {
    return Image(
        image: AssetImage(Constants.IMG_BACKGROUND),
        width: _itemWidth,
        height: _itemHeight,
        fit: BoxFit.fill,
        alignment: Alignment.center);
  }

  _getBackGround(_itemHeight, _itemWidth) {
    String url = 'https://f4gimages.s3.eu-central-1.amazonaws.com/' +
       '${widget.data['id']}' +
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


  _getLogo(_itemHeight, _itemWidth) {
    String logoUrl = 'https://f4gimages.s3.eu-central-1.amazonaws.com/' +
       '${widget.data['id']}' +
        "_logo.jpg";
    print(logoUrl);
    return Padding(
      padding: EdgeInsets.fromLTRB(_itemWidth / 3, _itemHeight / 2, 10, 0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          backgroundColor: Constants.LOGO_BG_COLOR,
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

  _getPlaceHolderLogo() {
    return Image(image: AssetImage(Constants.IMG_LOGO));
  }
}
