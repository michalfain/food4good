import 'package:flutter/material.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/widgets/main_logo_widget.dart';

class SettingsScreen extends StatelessWidget {
  static const String SCREEN_NAME = 'SettingsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: MainLogoWidget(), backgroundColor: Colors.white, iconTheme: new IconThemeData(color: Colors.grey),),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _getTopImage(),
              _getHeadline('הגדרות', Constants.HEADLINE_SIZE),
              _getTextBody('', Constants.BIG_TEXT_SIZE),
            ]),
      ),
    );
  }
}

_getHeadline(String y, double x) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        y,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: x),
      ),
    ),
  );
}

_getTextBody(String y, double x) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        y,
        style: TextStyle(fontSize: x),
      ),
    ),
  );
}

_getTopImage() {
  return Row(children: <Widget>[
    Expanded(
      child: Image(
          image: AssetImage(Constants.IMG_BACKGROUND),
          height: 150.0,
          width: 500.0),
    ),
  ]);
}
