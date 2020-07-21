import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:food4good_app/utils/constants.dart';

class AboutScreen extends StatefulWidget {
  static const String SCREEN_NAME = 'AboutScreen';

  @override
  State<StatefulWidget> createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {
  static const url = Constants.FOOD4GOOD_SITE;

  Future launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translations.of(context).getString(Strings.about),
          style: TextStyle(fontSize: Constants.SCREEN_APPBAR_FONT, color: Constants.SCREEN_APPBAR_COLOR),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              _getBodyText(Translations.of(context).getString(Strings.areYouHungryAndFrustrated), true),
              SizedBox(height: 20.0),
              _getBodyText(Translations.of(context).getString(Strings.weAreTheSolution), true),
              SizedBox(height: 5.0),
              _getBodyText(Translations.of(context).getString(Strings.food4GoodDeliciousLowCost)),
              SizedBox(height: 20.0),
              _getBodyText(Translations.of(context).getString(Strings.didYouKnow), true),
              SizedBox(height: 5),
              _getBodyText(Translations.of(context).getString(Strings.inIsraelEveryYear)),
              _getBodyText(Translations.of(context).getString(Strings.ridiculous)),
              _getBodyText(Translations.of(context).getString(Strings.weDecidedToTakeAction)),
              SizedBox(height: 20.0),
              _getBodyText(Translations.of(context).getString(Strings.howThisWorks), true),
              SizedBox(height: 5.0),
              _getBodyText(Translations.of(context).getString(Strings.likeFood4GoodPage)),
              _getBodyText(Translations.of(context).getString(Strings.getLinkforAppDownload)),
              _getBodyText(Translations.of(context).getString(Strings.chooseGreatDishes)),
              _getBodyText(Translations.of(context).getString(Strings.goToPickUpYourOrderAndPay)),
              _getBodyText(Translations.of(context).getString(Strings.tellAllYourFriends)),
              SizedBox(height: 10.0),
              _getBodyText(Translations.of(context).getString(Strings.forFurtherInformationPleaseVisitOurWebsite), true),
              SizedBox(height: 10.0),
              _getSite(),
              SizedBox(height: 20.0),
              _getBodyText(Translations.of(context).getString(Strings.pleaseHelpUsSpreadTheWord), true),
            ]),
          ),
        ),
        //), //Expanded
      ),
    );
  }

  _getSite() {
    return GestureDetector(
      onTap: () {
        launchUrl(url);
      },
      child: Text(
        url,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16),
      ),
    );
  }

  _getBodyText(String rowText, [bool isBold = false]) {
    return Text(
      rowText,
      style:
          TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
    );
  }
}
