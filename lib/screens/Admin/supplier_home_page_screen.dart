import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/supplier_admin_info_provider.dart';
//import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/widgets/widget_background_image_rest_name.dart';
import 'package:food4good_app/widgets/get_supplier_bottom_bar_nav.dart';

import 'supplier_orders_screen.dart';
import 'supplier_update_dishes_screen.dart';
import 'suppliers_update_details_screen.dart';
import 'package:food4good_app/utils/constants.dart';

class SupplierHomePageScreen extends StatefulWidget {
  final String token;
  static const String SCREEN_NAME = 'SupplierHomePageScreen';

  SupplierHomePageScreen({
    Key key,
    this.token,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SupplierHomePageScreen();
  }
}

class _SupplierHomePageScreen extends State<SupplierHomePageScreen> {
  SupplierAdminInfoProvider _getSupplierAdminInfo;
  dynamic data;
//  SupplierInfoDTO _supplierInfoDTO;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getSupplierAdminInfo = new SupplierAdminInfoProvider(loadAdminInfoCallBack);
    _getSupplierAdminInfo.execute();
    Size size = MediaQuery.of(context).size;
    double _itemWidth = size.width - 8;
    double _itemHeight = size.height / 4;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BGImageRestNameWidget(data),
           // SizedBox(height: 30.0),
            _getMiddleLines(),
          ],
        ),
      ),
      bottomNavigationBar: GetSupplierBottomBarNav('${widget.token}', 3),
    );
  }

  _getMiddleLines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.restaurant, color: Constants.ICON_COLOR),
              label: Text(
                'הזמנות',
                style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
              ),
              onPressed: () {
                //passing token argument to next page
                var route2 = new MaterialPageRoute(
                  builder: (BuildContext context) => new SupplierOrdersScreen(
                    token: '${widget.token}',
                  ),
                );
                Navigator.of(context).push(route2);
              },
            ),
          ],
        ),
        SizedBox(height: 20.0),
        _getDivider(),
        SizedBox(height: 20.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.restaurant_menu, color: Constants.ICON_COLOR),
              label: Text('עדכון מנות', style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE)),
              onPressed: () {
                //passing token argument to next page
                var route2 = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new SupplierUpdateDishesScreen(
                    token: '${widget.token}',
                  ),
                );
                Navigator.of(context).push(route2);
              },
            ),
          ],
        ),
        SizedBox(height: 20.0),
        _getDivider(),
        SizedBox(height: 20.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.store, color: Constants.ICON_COLOR),
              label: Text(
                'עדכון פרטי העסק',
                style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
              ),
              onPressed: () {
                //passing token argument to next page
                var route2 = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new SupplierUpdateDetailsScreen(
                    token: '${widget.token}',
                  ),
                );
                Navigator.of(context).push(route2);
              },
            ),
          ],
        ),
        SizedBox(height: 20.0),
        _getDivider(),
      ],
    );
  }

  _getDivider() {
    return Divider(
      height: 10.0,
      indent: 5.0,
      thickness: 0.5,
      color: Colors.black,
    );
  }

  void loadAdminInfoCallBack(bool working, dynamic data) {
    if (working == true) {
      setState(() {
        this.data = data;
      });
      print("successfully load supplier data from admin/suppliers");
    } else {
      print("failed to load supplier data from admin/suppliers");
      Crashlytics.instance.log('Failed to load supplier data');
    }
  }

}
