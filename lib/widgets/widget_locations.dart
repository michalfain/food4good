import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food4good_app/controllers/favorite_controller.dart';
import 'package:food4good_app/dto/upper_bar_config.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetLocation extends StatefulWidget {
  WidgetLocation(this.supplierInfoDTO, this.locationColor);

  @override
  _WidgetLocationState createState() => _WidgetLocationState();

  final SupplierInfoDTO supplierInfoDTO;
  final Color locationColor;
}

class _WidgetLocationState extends State<WidgetLocation> {
  static Icon locationIcon = Icon(
    Icons.location_on,
    color: Constants.DISH_ORDER_SCREEN_LOCATION_COLOR,
    size: Constants.LOCATION_ICON_SIZE,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openMap();
      },
      child: Column(
        children: <Widget>[
          _buildLocationIconWidget(),
          _buildLocationCounterWidget(),
        ],
      ),
    );
  }

  Widget _buildLocationCounterWidget() {
    return Text(
      widget.supplierInfoDTO.address,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: Constants.DISH_ORDER_SCREEN_ADDRESS_FONT,
          color: widget.locationColor),
    );
  }

  Widget _buildLocationIconWidget() {
    return  Row(
        children: <Widget>[
          locationIcon,
          Text(
            widget.supplierInfoDTO.distance,
            style: TextStyle(
                color: widget.locationColor,
                fontSize: Constants.DISH_ORDER_SCREEN_ADDRESS_FONT),
          ),
        ],

    );
  }

  openMap() async {
    String url =
        "https://www.google.com/maps/search/?api=1&query=${widget.supplierInfoDTO.address}&travelmode=walking";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Maps';
    }
  }
}
