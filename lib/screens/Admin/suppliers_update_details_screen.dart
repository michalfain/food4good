import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/update_supplier_data_controller.dart';
import 'package:food4good_app/controllers/supplier_admin_info_provider.dart';
import 'package:food4good_app/dto/supplier_static_data.dart';
import 'package:food4good_app/screens/admin/supplier_home_page_screen.dart';
import 'package:food4good_app/widgets/widget_headline.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food4good_app/utils/constants.dart';

class SupplierUpdateDetailsScreen extends StatefulWidget {
  final String token;
  static const String SCREEN_NAME = 'SupplierUpdateDetailsScreen';

  SupplierUpdateDetailsScreen({
    Key key,
    this.token,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SupplierUpdateDetailsScreen();
  }
}

class _SupplierUpdateDetailsScreen extends State<SupplierUpdateDetailsScreen> {
  File _image;
  File _iconImage;
  final _controllerRestaurantName = TextEditingController();
  final _controllerAddress = TextEditingController();
  bool deletedImage;
  bool deletedIconImage;
  String address;
  String restaurantName;
  String open_hours;
  String msg = '';
  UpdateSupplierDataController updateData;
  String jsonSupplierStaticData = "";
  SupplierAdminInfoProvider _getSupplierAdminInfo;
  SupplierStaticDataDTO _supplierStaticInfoDTO;
  dynamic data;

  @override
  void initState() {
    super.initState();
  }

  //Future getImageFromCamera() async {
  //var image = await ImagePicker.pickImage(source: ImageSource.camera);

  //setState(() {
  //_image = image;
  //});
  //}

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      deletedImage = false;
    });
  }

  //Future getIconImageFromCamera() async {
  //var iconImage = await ImagePicker.pickImage(source: ImageSource.camera);

  // setState(() {
  // _iconImage = iconImage;
  //});
  //}

  Future getIconImageFromGallery() async {
    var iconImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _iconImage = iconImage;
      deletedIconImage = false;
    });
  }

  void dispose() {
    _controllerAddress.dispose();
    _controllerRestaurantName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getSupplierAdminInfo = new SupplierAdminInfoProvider(adminInfoCallBack);
    _getSupplierAdminInfo.execute();
    data != null ? address = data["address"].toString() : address = '';
    data != null ? restaurantName = data["supplierName"] : restaurantName = '';
    data != null ? open_hours = data["open_hours"].toString() : open_hours = '';
    _supplierStaticInfoDTO =
        new SupplierStaticDataDTO(address: this.address, restName: this.restaurantName, openHours: open_hours);
    updateData = new UpdateSupplierDataController(supplierDataCallBack);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Expanded(
              child: ListView(
                children: <Widget>[
                  HeadlineWidget('עדכון פרטי העסק'),
                  SizedBox(height: 30.0),
                  _getMiddleLines(),
                  SizedBox(height: 50.0),
                  _getLoadPic(),
                  SizedBox(height: 10.0),
                  _getLoadIcon(),
                  SizedBox(height: 40.0),
                  _getSaveButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar:  ,
    );
  }

  _getMiddleLines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'שם העסק',
          style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
        ),
        SizedBox(height: 10.0),
        getRestaurantName(),
        SizedBox(height: 20.0),
        Text(
          'כתובת',
          style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
        ),
        SizedBox(height: 10.0),
        getRestaurantAddress(),
      ],
    );
  }

  _getSaveButton() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
        ),
        ButtonTheme(
          minWidth: 325.0,
          height: 50.0,
          child: RaisedButton(
            color: Constants.BUTTON_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            onPressed: () {
              onButtonPressed();
            },
            child: Text(
              'לשמירה',
              style: TextStyle(color: Constants.BUTTON_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ),
        ),
      ],
    );
  }

  _getLoadPic() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
        ),
        ButtonTheme(
          minWidth: 180.0,
          height: 50.0,
          child: RaisedButton(
            color: Constants.BUTTON_DARKER_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            onPressed: () {
              getImageFromGallery();
            },
            child: Text(
              'העלאת תמונת רקע',
              style: TextStyle(color: Constants.BUTTON_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ),
        ),
        SizedBox(width: 15.0),
        deletedImage != false
            ? Text(
                'No image selected',
                style: TextStyle(fontSize: 12.0),
              )
            : Row(
                children: <Widget>[
                  Image.file(_image, height: 50.0, width: 50.0),
                  FlatButton.icon(
                    icon: Icon(Icons.delete_forever),
                    label: Text(''),
                    onPressed: () {
                      setState(() {
                        deletedImage = true;
                      });
                    },
                  ),
                ],
              ),
      ],
    );
  }

  _getLoadIcon() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
        ),
        ButtonTheme(
          minWidth: 180.0,
          height: 50.0,
          child: RaisedButton(
            color: Constants.BUTTON_DARKER_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            onPressed: () {
              getIconImageFromGallery();
            },
            child: Text(
              'העלאת אייקון',
              style: TextStyle(color: Constants.BUTTON_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ),
        ),
        SizedBox(width: 15.0),
        deletedIconImage != false
            ? Text(
                'No image selected',
                style: TextStyle(fontSize: 12.0),
              )
            : Row(
                children: <Widget>[
                  Image.file(_iconImage, height: 50.0, width: 50.0),
                  FlatButton.icon(
                    icon: Icon(Icons.delete_forever),
                    label: Text(''),
                    onPressed: () {
                      setState(() {
                        deletedIconImage = true;
                      });
                    },
                  ),
                ],
              ),
      ],
    );
  }

  getRestaurantName() {
    return Container(
      child: TextField(
        controller: _controllerRestaurantName,
        decoration: InputDecoration(hintText: restaurantName),
      ),
      padding: EdgeInsets.only(left: 100.0, top: 0, right: 2, bottom: 0),
      decoration: BoxDecoration(
        color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
        border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
        ],
      ),
    );
  }

  getRestaurantAddress() {
    return Container(
      child: TextField(
        controller: _controllerAddress,
        decoration: InputDecoration(hintText: address),
      ),
      padding: EdgeInsets.only(left: 100.0, top: 0, right: 2, bottom: 0),
      decoration: BoxDecoration(
        color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
        border: Border.all(color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Constants.SUPPLIER_SHADOW_TEXT_FIELD_BORDER_COLOR, offset: Offset(3.0, 3.0)),
        ],
      ),
    );
  }

  onButtonPressed() {
    _controllerAddress.text != null ? address = _controllerAddress.text : address = address;
    _controllerRestaurantName.text != null
        ? restaurantName = _controllerRestaurantName.text
        : restaurantName = restaurantName;
    _supplierStaticInfoDTO =
        new SupplierStaticDataDTO(address: this.address, restName: this.restaurantName, openHours: this.open_hours);
    jsonSupplierStaticData = jsonEncode(_supplierStaticInfoDTO);
    updateData.execute(jsonSupplierStaticData);
  }

  void adminInfoCallBack(bool working, dynamic data) {
    if (working == true) {
      setState(() {
        //to show the original rest name and address in the user interface
        this.data = data;
      });
      print("successfully load supplier data from admin/suppliers");
    } else {
      print("failed to load supplier data from admin/suppliers");
      Crashlytics.instance.log('Failed to load supplier data');
    }
  }

  void supplierDataCallBack(bool updated, String msg) {
    if (updated == true) {
      this.msg = "המידע עודכן!";
      showDialogMsg();
    } else {
      this.msg = "המידע לא עודכן עקב בעיה טכנית. אנא נסה שוב במועד מאוחר יותר. שם התקלה: " + msg;
      showDialogMsg();
    }
  }

  showDialogMsg() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("סטטוס: "),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('סגור'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('חזור לעמוד הקודם'),
              onPressed: () {
                Navigator.pushNamed(context, SupplierHomePageScreen.SCREEN_NAME);
              },
            ),
          ],
        );
      },
    );
  }
}
