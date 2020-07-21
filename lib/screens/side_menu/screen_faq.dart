import 'package:flutter/material.dart';
import 'package:food4good_app/widgets/widget_headline.dart';
import 'package:food4good_app/widgets/main_logo_widget.dart';

class FAQScreen extends StatefulWidget {
  static const String SCREEN_NAME = 'FAQScreen';

  @override
  State<StatefulWidget> createState() {
    return _FAQScreen();
  }
}

class _FAQScreen extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: MainLogoWidget(), backgroundColor: Colors.white, iconTheme: new IconThemeData(color: Colors.grey),),
      body: SafeArea(
        child: Center(
          child: HeadlineWidget('שאלות ותשובות'),
        ),
      ),
    );
  }
}
