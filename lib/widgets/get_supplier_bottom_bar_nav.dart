import 'package:flutter/material.dart';
import 'package:food4good_app/screens/screen_main/screen_main.dart';
import 'package:food4good_app/screens/admin/supplier_orders_screen.dart';
import 'package:food4good_app/utils/constants.dart';

class GetSupplierBottomBarNav extends StatefulWidget {
  final String token;
  final int pageIndex;

  GetSupplierBottomBarNav(this.token, this.pageIndex);

  @override
  _GetSupplierBottomBarNavState createState() => _GetSupplierBottomBarNavState();
}

class _GetSupplierBottomBarNavState extends State<GetSupplierBottomBarNav> {
  int _currentIndex = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          if (_currentIndex == 0) {
            //TODO: EMIL: Removed because removed MenuScreen.
            //Navigator.pushNamed(context, MenuScreen.SCREEN_NAME);
          }
          if (_currentIndex == 1) {
            Navigator.pushNamed(context, MainScreen.SCREEN_NAME);
          }
          if (_currentIndex == 2 && '${widget.pageIndex}'!= '2') { //if it's not the supplier Order Screen
            var route2 = new MaterialPageRoute(
              builder: (BuildContext context) =>
              new SupplierOrdersScreen(
                token: '${widget.token}',
              ),
            );
            Navigator.of(context).push(route2);
          }
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.menu, color: Constants.BOTTOM_NAV_BUTTONS_COLOR),
          title: Text('תפריט'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Constants.BOTTOM_NAV_BUTTONS_COLOR),
          title: Text('דף הבית'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant, color: Constants
              .BOTTOM_NAV_BUTTONS_COLOR),
          title: Text('הזמנות'),
        ),
      ],
    );
  }
}