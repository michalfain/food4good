import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/dto/upper_bar_config.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/screens/user/screen_dish_order.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/widgets/widget_like.dart';
import 'package:url_launcher/url_launcher.dart';

class UpperBar extends StatefulWidget {
  final SupplierInfoDTO _supplierInfoDTO;
  final UpperBarConfig _upperBarConfig;

  UpperBar(this._supplierInfoDTO, this._upperBarConfig);

  @override
  _UpperBarState createState() => _UpperBarState();
}

class _UpperBarState extends State<UpperBar> {
  static final String TAG = "UpperBar";

  @override
  Widget build(BuildContext context) {
    if (widget._upperBarConfig.isClickable) {
      return GestureDetector(
        onTap: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new DishOrderScreen(supplierInfoDTO: widget._supplierInfoDTO),
          );
          Navigator.of(context).push(route);
        },
        child: _buildBody(),
      );
    } else {
      return _buildBody();
    }
  }

  Widget _buildBody() {
    return Container(
      height: 170,
      child: Stack(
        children: <Widget>[
          _getBackGround(),
          _getLogo(),
          _buildBusinessInformationAndLikesRow(),
        ],
      ),
    );
  }

  Widget _buildBusinessInformationAndLikesRow() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildBusinessInformationWidget(),
            _getLikes(),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInformationWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          openMap();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            getRestName(),
            getDistance(),
            getAddress(),
          ],
        ),
      ),
    );
  }

  getRestName() {
    if (widget._upperBarConfig.isRestNameShow)
      return Text(
        widget._supplierInfoDTO.restName,
        style: TextStyle(
            color: Constants.SUPPLIER_NAME_COLOR,
            fontSize: Constants.SUPPLIER_NAME_FONT),
      );
    return SizedBox();
  }

  getDistance() {
    if (widget._upperBarConfig.isDistanceShow)
      return Row(
        children: <Widget>[
          Icon(Icons.location_on, color: Constants.UPPER_BAR_ITEM_COLOR),
          Text(
            widget._supplierInfoDTO.distance,
            style: TextStyle(
                color: Constants.UPPER_BAR_ITEM_COLOR,
                fontSize: Constants.UPPER_BAR_TEXT_SIZE),
          ),
        ],
      );
    return SizedBox();
  }

  getAddress() {
    if (widget._upperBarConfig.isAddressShow)
      return Text(
        widget._supplierInfoDTO.address,
        style: TextStyle(
            color: Constants.UPPER_BAR_ITEM_COLOR,
            fontSize: Constants.UPPER_BAR_TEXT_SIZE),
      );
    return SizedBox();
  }

  _getLikes() {
    if (widget._upperBarConfig.isLikesShow ||
        widget._upperBarConfig.isHeartShow)
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
        child: WidgetLike(widget._supplierInfoDTO, widget._upperBarConfig,
            Constants.UPPER_BAR_ITEM_COLOR),
      );
    else {
      return SizedBox();
    }
  }

  _getBackGround() {
    return CachedNetworkImage(
      placeholder: (context, restId) => _getPlaceHolderBackGround(),
      imageUrl: widget._supplierInfoDTO.backgroundImage,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.darken),
          ),
        ),
      ),
    );
  }

  _getPlaceHolderBackGround() {
    return Image(
      image: AssetImage(Constants.IMG_BACKGROUND),
      //width: widget._itemWidth,
      fit: BoxFit.cover,
      //alignment: Alignment.center
    );
  }

  _getLogo() {
    if (widget._upperBarConfig.isLogoShow)
      return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            backgroundColor: Constants.CIRCLE_AVATAR_RADIUS_CHECKOUT_COLOR,
            radius: Constants.CIRCLE_AVATAR_RADIUS,
            child: ClipOval(
              child: CachedNetworkImage(
                placeholder: (context, restId) => _getPlaceHolderLogo(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                imageUrl: widget._supplierInfoDTO.logoImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );
    return null;
  }

  _getPlaceHolderLogo() {
    return Image(image: AssetImage(Constants.IMG_LOGO));
  }

  openMap() async {
    String url =
        "https://www.google.com/maps/search/?api=1&query=${widget._supplierInfoDTO.address}&travelmode=walking";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Crashlytics.instance.log('Could not launch Maps');
    }
  }
}
