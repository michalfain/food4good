import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food4good_app/dto/supplier_info.dart';
import 'package:food4good_app/services/service_supplier.dart';
import 'package:food4good_app/utils/data_model.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/widgets/supplier_item.dart';
import 'package:food4good_app/widgets/widget_loading_with_text.dart';
import 'package:provider/provider.dart';

class PageSuppliers extends StatefulWidget {
  @override
  _PageSuppliersState createState() => _PageSuppliersState();
}

class _PageSuppliersState extends State<PageSuppliers> {
  var _searchView = new TextEditingController();
  String _query = "";

  bool _firstSearch = true;
  TextEditingController _textEditorController = new TextEditingController();
  StreamSubscription _iosSubscription;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildSearchField(),
          Expanded(child: _buildSuppliersListView()),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    new Timer(const Duration(seconds: 1), () {
      var dataModel = Provider.of<DataModel>(context, listen: false);
      dataModel.loadSuppliers();
    });

    //TODO: EMIL: Removed because removed MenuScreen
    //handlePushMessages();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildSearchField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Theme(
                data: new ThemeData(primaryColor: Colors.green, primaryColorDark: Colors.green),
                child: TextFormField(
                  controller: _searchView,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.green),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    labelText: Translations.of(context).getString(Strings.lblSearchByBusinessName),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.green,
                    ),
                    suffixIcon: new IconButton(
                      icon: new Icon(
                        Icons.cancel,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchView.text = "";
                          _query = "";
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuppliersListView() {
    var dataModel = Provider.of<DataModel>(context, listen: true);
    if (dataModel.isLoadingSuppliers) {
      return WidgetLoadingWithText(Translations.of(context).getString(Strings.loadingSuppliers));
    } else {
      var list = dataModel.supplierItemsMap.values.toList();
      if (list.isEmpty) {
        return _buildEmptySuppliersListWidget();
      } else {
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return SupplierItem(list[index]);
          },
        );
      }
    }
  }

  void searchAddListener() {
    _searchView.addListener(() {
      if (_searchView.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchView.text;
        });
      }
    });
  }

  _performSearch() {
    List<SupplierInfoDTO> _supplierItemsFiltered = [];
    List<String> searchResults = SuppliersService.searchByName(
        _query, Provider.of<DataModel>(context, listen: false).supplierItemsMap.values.toList());
    for (var restId in searchResults) {
      _supplierItemsFiltered.add(Provider.of<DataModel>(context, listen: false).supplierItemsMap[restId]);
    }
    return _supplierItemsFiltered;
  }

  Widget _buildEmptySuppliersListWidget() {
    return Center(child: Text('No suppliers'));
  }

/* void handlePushMessages() {
    if (Platform.isIOS) {
      _iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Navigator.pushNamed(context, MenuScreen.SCREEN_NAME);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        Navigator.pushNamed(context, MenuScreen.SCREEN_NAME);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Navigator.pushNamed(context, MenuScreen.SCREEN_NAME);
      },
    );
  }*/
}
