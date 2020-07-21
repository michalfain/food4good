import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food4good_app/screens/side_menu/screen_about.dart';
import 'package:food4good_app/screens/side_menu/widget_display_pdf.dart';
import 'package:food4good_app/utils/constants.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDrawer extends StatefulWidget {
  PageDrawer(
      {Key key, /*@required this.firebaseUser,*/ @required this.onShare});

//  final FirebaseUser firebaseUser;
  final VoidCallback onShare;

  @override
  _PageDrawerState createState() => _PageDrawerState();
}

class _PageDrawerState extends State<PageDrawer> {
  static const String TAG = "PageDrawer";
  String _version = "";
  String _buildNumber = "";
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _fillVersionDetails();
  }

  _fillVersionDetails() {
    if (!kIsWeb) {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        setState(() {
          _version = packageInfo.version;
          _buildNumber = packageInfo.buildNumber;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      child: Drawer(
        child: Container(
          width: 350,
          color: Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              /*DrawerHeader(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      Config.appName(context),
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        fontFamily: 'Righteous',
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    begin: const FractionalOffset(0.1, 0.1),
                    end: const FractionalOffset(0.1, 0.9),
                    colors: [Color(0xff0fadd4), Color(0xff566fe9), Colors.deepPurple[900]],
                  ),
                ),
              ),*/
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  Translations.of(context).getString(Strings.menu),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 23,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    /*ListTile(
                      leading: Icon(Icons.store, color: Constants.ICON_COLOR),
                      title: Text(Translations.of(context).getString(Strings.connectToBusiness)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, SupplierLogInScreen.SCREEN_NAME);
                      },
                    ),
                    ListTile(
                        leading: Icon(Icons.notifications, color: Constants.ICON_COLOR),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(Translations.of(context).getString(Strings.notifications)),
                            Row(
                              children: <Widget>[
                                Text(Translations.of(context).getString(Strings.no),
                                  style: TextStyle(color: !isSwitched ? Constants.SCREEN_TEXT_COLOR : Constants.RESTAURANT_INFO_ROW_COLOR,
                                    fontSize: Constants.TEXT_BUTTON_SIZE),),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                  },
                                  activeTrackColor: Constants.NOTIFICATION_ACTIVE_TRACK_COLOR,
                                  activeColor: Constants.NOTIFICATION_ACTIVE_COLOR,
                                ),
                                Text(Translations.of(context).getString(Strings.yes),
                                  style: TextStyle(color: isSwitched ? Constants.SCREEN_TEXT_COLOR : Constants.RESTAURANT_INFO_ROW_COLOR,
                                    fontSize: Constants.TEXT_BUTTON_SIZE),),
                                SizedBox(width: 5,)
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isSwitched = !isSwitched;
                          });
                        },
                    ),*/
                    ListTile(
                      leading: Icon(Icons.lock, color: Constants.ICON_COLOR),
                      title: Text(Translations.of(context)
                          .getString(Strings.privacyPolicy)),
                      onTap: () {
                        Navigator.pop(context);
                        var route2 = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new WidgetDisplayPdf(
                            pdfUrl: Constants.PRIVACY_POLICY_URL,
                            headline: Translations.of(context)
                                .getString(Strings.privacyPolicy),
                          ),
                        );
                        Navigator.of(context).push(route2);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_view_day,
                          color: Constants.ICON_COLOR),
                      title: Text(Translations.of(context)
                          .getString(Strings.termsOfService)),
                      onTap: () {
                        Navigator.pop(context);
                        var route2 = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new WidgetDisplayPdf(
                            pdfUrl: Constants.USER_TERMS_URL,
                            headline: Translations.of(context)
                                    .getString(Strings.termsOfService),
                          ),
                        );
                        Navigator.of(context).push(route2);
                      },
                    ),
                    /* kIsWeb
                        ? Container()
                        : ListTile(
                      leading: Icon(Icons.share, color: Constants.ICON_COLOR),
                      title: Text(Translations.of(context).getString(Strings.share)),
                      onTap: () {
                        Navigator.pop(context);
                        new Future.delayed(const Duration(milliseconds: 300), () {
                          widget.onShare();
                        });
                      },
                    ),*/
                    ListTile(
                      leading: Icon(Icons.info, color: Constants.ICON_COLOR),
                      title: Text(
                          Translations.of(context).getString(Strings.about)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AboutScreen.SCREEN_NAME);
                      },
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.mail_outline, color: Constants.ICON_COLOR),
                      title: Text(
                          Translations.of(context).getString(Strings.contact)),
                      onTap: () {
                        Navigator.pop(context);
                        _showContactUs();
                      },
                    ),
                    /* ListTile(
                      leading: Icon(FontAwesomeIcons.question, color: Constants.ICON_COLOR),
                      title: Text(Translations.of(context).getString(Strings.faq)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, FAQScreen.SCREEN_NAME);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app, color: Constants.ICON_COLOR),
                      title: Text(Translations.of(context).getString(Strings.logout)),
                      onTap: () {
                        //_callLogout();
                      },
                    ),*/
                    kIsWeb
                        ? Container()
                        : ListTile(
                            title: Text(
                                "${Translations.of(context).getString(Strings.version)}: $_version ($_buildNumber)"),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  Widget _buildName() {
    Text resultText;
    if (widget.firebaseUser != null) {
      if (widget.firebaseUser.displayName != null) {
        resultText = Text(widget.firebaseUser.displayName);
      }
    }
    return resultText;
  }

  Widget _buildEmail() {
    Text resultText;
    if (widget.firebaseUser != null) {
      if (widget.firebaseUser.email != null) {
        resultText = Text(widget.firebaseUser.email);
      }
    }
    return resultText;
  }

  ImageProvider _buildUserPhoto() {
    NetworkImage resultImage;
    if (widget.firebaseUser != null) {
      if (widget.firebaseUser.photoUrl != null) {
        resultImage = NetworkImage(widget.firebaseUser.photoUrl);
      }
    }
    return resultImage;
  }*/

/*  _callLogout() {
//    GoogleSignIn googleSignIn = GoogleSignIn();
//
//    if (googleSignIn.currentUser != null) {
//      googleSignIn.signOut();
//      googleSignIn.disconnect();
//    }
    _auth.signOut();
    Navigator.pop(context);
    PageShower.showSignUp(context);
  }*/

  _showContactUs() async {
    var url = 'mailto:support@food4good.co.il?subject=' +
        Translations.of(context).getString(Strings.contact);
    var encoded = Uri.encodeFull(url);
    if (await canLaunch(encoded)) {
      await launch(encoded);
    } else {
      throw 'Could not launch $encoded';
    }
  }
}
