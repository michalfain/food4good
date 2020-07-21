import 'package:flutter/material.dart';
import 'package:food4good_app/dto/enum_order_status.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/widgets/open_order_item.dart';
import 'package:provider/provider.dart';

class OpenOrdersScreen extends StatefulWidget {
  OpenOrdersScreen();

  @override
  _OpenOrdersScreenState createState() => _OpenOrdersScreenState();
}

class _OpenOrdersScreenState extends State<OpenOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context, listen: true);
    return Scaffold(body: _buildBody(dataModel));
  }

  _buildBody(DataModel dataModel) {
    var userOrdersList = dataModel.userOrdersList;
    List<OrderDTO> openOrders = [];

    for (OrderDTO order in userOrdersList) {
      if (order.status == OrderStatus.created) {
        openOrders.add(order);
      }
    }

    if (userOrdersList.isEmpty) {
      return Center(
        child: Text(Translations.of(context).getString(Strings.youDoNotHaveOpenOrders)),
      );
    } else {
      return ListView.builder(
        itemCount: openOrders.length,
        itemBuilder: (BuildContext context, int index) {
          return OpenOrderItem(openOrders[index]);
        },
      );
    }
  }
}
