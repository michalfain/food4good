import 'package:flutter/material.dart';
import 'package:food4good_app/screens/screen_main/page_drawer.dart';
import 'package:food4good_app/screens/screen_main/page_suppliers.dart';
import 'package:food4good_app/screens/screen_main/page_orders.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/widgets/widget_bottom_navigation_bar.dart';
import 'package:food4good_app/widgets/main_logo_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String SCREEN_NAME = 'MainScreen';

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  List _pages = [
    PageSuppliers(),
    PageOrders(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MainLogoWidget(),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.grey),
      ),
      drawer: PageDrawer(),
      body: SafeArea(
        child: Consumer<DataModel>(
          builder: (context, dataModel, child) {
            return Center(child: _pages[dataModel.tabIndex]);
          },
        ),
      ),
      bottomNavigationBar: GetBottomNavBar(),
    );
  }
}
