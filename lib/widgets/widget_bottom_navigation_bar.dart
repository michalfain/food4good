import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/undelivered_orders_provider.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:provider/provider.dart';

class GetBottomNavBar extends StatefulWidget {
  @override
  _GetBottomNavBarState createState() => _GetBottomNavBarState();
}

class _GetBottomNavBarState extends State<GetBottomNavBar> {
  BottomNavigationBadge badger = new BottomNavigationBadge(
      backgroundColor: Constants.BADGE_BG_COLOR,
      badgeShape: BottomNavigationBadgeShape.circle,
      textColor: Constants.SCREEN_TEXT_COLOR,
      position: BottomNavigationBadgePosition.bottomRight);
  int numOfNewOrders = 0;

  @override
  initState() {
    super.initState();
    UndeliveredOrdersProvider undeliveredOrdersProvider = new UndeliveredOrdersProvider(loadOrderNoCallBack);
    undeliveredOrdersProvider.execute();
  }

  void loadOrderNoCallBack(int _numOfNewOrders) {
    setState(() {
      numOfNewOrders = _numOfNewOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(Icons.home, color: Constants.ICON_COLOR), title: Text(Translations.of(context).getString(Strings.homePage))),
      BottomNavigationBarItem(
          icon: Icon(Icons.restaurant, color: Constants.ICON_COLOR), title: Text(Translations.of(context).getString(Strings.myOrders))),
    ];

    var dataModel = Provider.of<DataModel>(context, listen: false);
    return BottomNavigationBar(
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 25),
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 20),
        items: numOfNewOrders > 0 ? badger.setBadge(items, numOfNewOrders.toString(), 1) : items,
        currentIndex: dataModel.tabIndex,
        onTap: (int index) {
          dataModel.tabIndex = index;
        });
  }
}
