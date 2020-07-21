import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:food4good_app/screens/screen_main/orders/screen_closed_orders.dart';
import 'package:food4good_app/screens/screen_main/orders/screen_open_orders.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/widgets/widget_loading_with_text.dart';

class PageOrders extends StatefulWidget {
  static const String SCREEN_NAME = 'OrdersScreen';

  @override
  State<StatefulWidget> createState() {
    return _OrdersScreen();
  }
}

class _OrdersScreen extends State<PageOrders> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    var dataModel = Provider.of<DataModel>(context, listen: false);
    dataModel.loadOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomSheet: _buildTabBar(context),
      body: _buildTabBarView(),
    );
  }

  Widget _buildTabBarView() {
    var dataModel = Provider.of<DataModel>(context, listen: true);
    if (dataModel.isLoadingOrders) {
      return WidgetLoadingWithText(Translations.of(context).getString(Strings.loadingOrders));
    } else {
      return TabBarView(
        controller: _tabController,
        children: <Widget>[
          OpenOrdersScreen(),
          ClosedOrdersScreen(),
        ],
      );
    }
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(controller: _tabController, tabs: <Tab>[
      Tab(
          child: Text(Translations.of(context).getString(Strings.open),
              style: TextStyle(color: Constants.TAB_TEXT_COLOR, fontSize: Constants.TAB_TEXT_FONT_SIZE))),
      Tab(
          child: Text(Translations.of(context).getString(Strings.close),
              style: TextStyle(color: Constants.TAB_TEXT_COLOR, fontSize: Constants.TAB_TEXT_FONT_SIZE))),
    ]);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Constants.APPBAR_BG_COLOR_SCREEN,
      title: Text(
        Translations.of(context).getString(Strings.myOrders),
        style: TextStyle(color: Constants.SCREEN_APPBAR_COLOR, fontSize: Constants.SCREEN_APPBAR_FONT),
      ),
    );
  }
}
