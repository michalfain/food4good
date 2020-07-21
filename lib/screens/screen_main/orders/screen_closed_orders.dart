import 'package:flutter/material.dart';
import 'package:food4good_app/dto/enum_order_status.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/widgets/closed_orders_item.dart';
import 'package:provider/provider.dart';

class ClosedOrdersScreen extends StatefulWidget {
  @override
  _ClosedOrdersScreenState createState() => _ClosedOrdersScreenState();
}

class _ClosedOrdersScreenState extends State<ClosedOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context);
    return Scaffold(body: _buildBody(dataModel));
  }

  _buildBody(DataModel dataModel) {
    var userOrdersList = dataModel.userOrdersList;
    List<OrderDTO> closedOrders = [];

    for (OrderDTO order in userOrdersList) {
      if (order.status == OrderStatus.canceled || order.status == OrderStatus.delivered) {
        closedOrders.add(order);
      }
    }

    if (userOrdersList.isEmpty) {
      return Center(
        child: Text(Translations.of(context).getString(Strings.youDoNotHaveClosedOrders)),
      );
    } else {
      return ListView.builder(
        itemCount: closedOrders.length,
        itemBuilder: (BuildContext context, int index) {
          return ClosedOrderItem(closedOrders[index]);
        },
      );
    }
  }
}
