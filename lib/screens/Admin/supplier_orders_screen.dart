import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/orders_by_supplier_provider.dart';
import 'package:food4good_app/dto/order.dart';
import 'package:food4good_app/widgets/get_supplier_bottom_bar_nav.dart';
import 'package:food4good_app/widgets/widget_headline.dart';
import 'package:food4good_app/widgets/orders_details_frame.dart';
import 'package:food4good_app/utils/constants.dart';

class SupplierOrdersScreen extends StatefulWidget {
  final String token;
  static const String SCREEN_NAME = 'SupplierOrdersScreen';

  SupplierOrdersScreen({
    Key key,
    this.token,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SupplierOrdersScreen();
  }
}

class _SupplierOrdersScreen extends State<SupplierOrdersScreen> {
  bool isSwitched = true;
  dynamic data;
  int numOfOrders;
  OrdersBySupplierProvider listOfOrdersAll;
  List listOfOrders = new List();
  DateTime _dateTime;
  var now = new DateTime.now();
  var formattedDate;
  List OrderFilterAll = new List();
  List OrderFilter = [];
  bool isButtonAllPressed = true;
  bool isButtonOpenPressed = false;
  bool isButtonClosePressed = false;
  bool isButtonTodayPressed = true;
  bool isButtonDatePressed = false;
  bool first = true;
  List<OrderDTO> listOfOrdersFromJson = new List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrdersBySupplierProvider listOfOrdersALL =
        new OrdersBySupplierProvider(supplierOrdersCallBack);
    //listOfOrders = listOfOrdersALL.getOrders('@#wes'); //SPECIFIC LIST OF ORDERS BY TOKEN
    listOfOrdersALL.execute('${widget.token}');
    if (listOfOrders != null) {
      numOfOrders = listOfOrders.length;
      OrderFilterAll = listOfOrders;
    } else
      numOfOrders = 0;

    if (first == true) OrderFilter = OrderFilterAll;
    first = false;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            HeadlineWidget('הזמנות ' + '(' + numOfOrders.toString() + ')'),
            SizedBox(height: 10.0),
            _getOrderStatusFilter(),
            SizedBox(height: 10.0),
            _getDateFilter(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  showListOfOrders(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetSupplierBottomBarNav('${widget.token}', 2),
    );
  }

  _getOrderStatusFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'סטטוס הזמנות',
              style: TextStyle(
                  color: Constants.SCREEN_TEXT_COLOR,
                  fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 50.0,
                  height: 30.0,
                  child: RaisedButton(
                    color: isButtonAllPressed ? Colors.black54 : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: () {
                      setState(() {
                        isButtonAllPressed = !isButtonAllPressed;
                        isButtonClosePressed = false;
                        isButtonOpenPressed = false;
                        isButtonDatePressed = false;
                        isButtonTodayPressed = false;
                        OrderFilter = OrderFilterAll;
                      });
                    },
                    child: Text(
                      'כולן',
                      style: TextStyle(
                          color: isButtonAllPressed
                              ? Constants
                                  .SUPPLIER_ORDERS_BUTTON_PRESSED_TEXT_COLOR
                              : Constants.SUPPLIER_ORDERS_BUTTON_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0),
            ButtonTheme(
              minWidth: 50.0,
              height: 30.0,
              child: RaisedButton(
                color: isButtonOpenPressed ? Colors.black54 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.grey)),
                onPressed: () {
                  setState(() {
                    isButtonOpenPressed = !isButtonOpenPressed;
                    isButtonClosePressed = false;
                    isButtonAllPressed = false;
                    isButtonDatePressed = false;
                    isButtonTodayPressed = false;
                    OrderFilter =
                        OrderFilterAll.where((i) => (i.status == 1)).toList();
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text(
                      ' פתוחות',
                      style: TextStyle(
                          color: isButtonOpenPressed
                              ? Constants
                                  .SUPPLIER_ORDERS_BUTTON_PRESSED_TEXT_COLOR
                              : Constants.SUPPLIER_ORDERS_BUTTON_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            ButtonTheme(
              minWidth: 50.0,
              height: 30.0,
              child: RaisedButton(
                color: isButtonClosePressed ? Colors.black54 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.grey)),
                onPressed: () {
                  setState(() {
                    isButtonClosePressed = !isButtonClosePressed;
                    isButtonOpenPressed = false;
                    isButtonAllPressed = false;
                    isButtonDatePressed = false;
                    isButtonTodayPressed = false;
                    OrderFilter =
                        OrderFilterAll.where((i) => (i.status == 2)).toList();
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.red,
                    ),
                    Text(
                      ' סגורות',
                      style: TextStyle(
                          color: isButtonClosePressed
                              ? Constants
                                  .SUPPLIER_ORDERS_BUTTON_PRESSED_TEXT_COLOR
                              : Constants.SUPPLIER_ORDERS_BUTTON_TEXT_COLOR,
                          fontSize: Constants.BIG_TEXT_SIZE),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
//        Text(
//          data.toString(),
//        ),
      ],
    );
  }

  _getDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'תאריך',
              style: TextStyle(
                  color: Constants.SCREEN_TEXT_COLOR,
                  fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            ButtonTheme(
              minWidth: 50.0,
              height: 30.0,
              child: RaisedButton(
                color: isButtonTodayPressed ? Colors.black54 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.grey)),
                onPressed: () {
                  setState(() {
                    formattedDate = "${now.day}-${now.month}-${now.year}";
                    OrderFilter = OrderFilterAll.where(
                        (i) => (i.date == formattedDate.toString())).toList();
                    isButtonTodayPressed = !isButtonTodayPressed;
                    isButtonDatePressed = false;
                  });
                },
                child: Text(
                  'היום',
                  style: TextStyle(
                      color: isButtonTodayPressed
                          ? Constants.SUPPLIER_ORDERS_BUTTON_PRESSED_TEXT_COLOR
                          : Constants.SUPPLIER_ORDERS_BUTTON_TEXT_COLOR,
                      fontSize: Constants.BIG_TEXT_SIZE),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            ButtonTheme(
              minWidth: 50.0,
              height: 30.0,
              child: RaisedButton(
                color: isButtonDatePressed ? Colors.black54 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.grey)),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  ).then((date) {
                    setState(() {
                      _dateTime = date;
                      formattedDate =
                          "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}";
                      OrderFilter = OrderFilterAll.where(
                          (i) => (i.date == formattedDate.toString())).toList();
                      isButtonDatePressed = true;
                      isButtonTodayPressed = false;
                      isButtonClosePressed = false;
                      isButtonOpenPressed = false;
                    });
                  });
                },
                child: Text(
                  'בחירת תאריך',
                  style: TextStyle(
                      color: isButtonDatePressed
                          ? Constants.SUPPLIER_ORDERS_BUTTON_PRESSED_TEXT_COLOR
                          : Constants.SUPPLIER_ORDERS_BUTTON_TEXT_COLOR,
                      fontSize: Constants.BIG_TEXT_SIZE),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              formattedDate == null ? '' : formattedDate.toString(),
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ],
        ),
      ],
    );
  }

  //This method shows the orders.
  //according to the buttons above(open/ close/ all)
  showListOfOrders() {
    if (OrderFilter != null)
      return Column(
        children: <Widget>[
          for (int i = 0; i < OrderFilter.length; i++)
            OrdersDetailsFrame(OrderFilter[i]),
        ],
      );
  }

  void supplierOrdersCallBack(dynamic data) {
    setState(() {
      this.data = data;
      listOfOrders = data;
    });
  }
}
