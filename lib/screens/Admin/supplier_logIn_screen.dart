import 'package:flutter/material.dart';
import 'package:food4good_app/controllers/login_provider.dart';
import 'package:food4good_app/screens/screen_main/page_orders.dart';
import 'package:food4good_app/utils/localization/strings.dart';
import 'package:food4good_app/utils/localization/translation_strings.dart';
import 'package:food4good_app/widgets/get_supplier_bottom_bar_nav.dart';
import 'package:food4good_app/widgets/main_logo_widget.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:food4good_app/utils/constants.dart';
import 'supplier_home_page_screen.dart';

class SupplierLogInScreen extends StatefulWidget {
  static const String SCREEN_NAME = 'SupplierLogInScreen';

  @override
  State<StatefulWidget> createState() {
    return _SupplierLogInScreen();
  }
}

class _SupplierLogInScreen extends State<SupplierLogInScreen> {
  String userName;
  String password;
  final _userNameController = TextEditingController(); //get text from userName input
  final _passwordController = TextEditingController(); //get text from password input
  LoginProvider login;
  dynamic _token;
  bool isConnected;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: MainLogoWidget(),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: (40.0)),
            _getHeadline(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getInsertUserName(),
                Container(
                  // height: 45.0,
                  //width: size.width/2 - 24,
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration.collapsed(),
                  ),
                  padding: EdgeInsets.only(left: 10.0, top: 3.0, right: 10, bottom: 3.0),
                  decoration: BoxDecoration(
                    color: Constants.SUPPLIER_TEXT_FIELD_BG_COLOR,
                    border: Border.all(
                      color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: (40.0)),
                _getInsertPassword(),
                PasswordField(
                  controller: _passwordController,
                  color: Colors.black38,
                  hasFloatingPlaceholder: false,
                  pattern: r'\w[^!@#$%&*()]',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(
                        width: 2,
                        color: Constants.SUPPLIER_TEXT_FIELD_BORDER_COLOR,
                      )),
                  errorMessage: 'סיסמא לא נכונה \$',
                  suffixIconEnabled: true,
                ),
                SizedBox(height: (40.0)),
                _getConnectionButton(),
              ],
            ),
          ],
        ),
      ),
      //bottomNavigationBar: GetSupplierBottomBarNav('', 2),
    );
  }

  _getHeadline() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 10.0),
      ),
      Icon(Icons.store, color: Constants.ICON_HEADLINE_COLOR),
      SizedBox(width: 10),
      Text(
        Translations.of(context).getString(Strings.connectToBusiness),
        style: TextStyle(color: Constants.HEADLINE_COLOR, fontSize: Constants.HEADLINE_SIZE),
      ),
    ]);
  }

  _getInsertUserName() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
        ),
        Column(
          children: <Widget>[
            Text(
              Translations.of(context).getString(Strings.userName),
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ],
    );
  }

  _getInsertPassword() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
        ),
        Column(
          children: <Widget>[
            Text(
              Translations.of(context).getString(Strings.password),
              style: TextStyle(color: Constants.SCREEN_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getConnectionButton() {
    return SizedBox(
      width: double.infinity,
      child: ButtonTheme(
        child: RaisedButton(
          color: Constants.BUTTON_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          onPressed: () {
            _loginButtonPressed();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              Translations.of(context).getString(Strings.login),
              style: TextStyle(color: Constants.BUTTON_TEXT_COLOR, fontSize: Constants.BIG_TEXT_SIZE),
            ),
          ),
        ),
      ),
    );
  }

  showUserPasswordNotCorrect() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("The user name or password is incorrect"),
        );
      },
    );
  }

  _loginButtonPressed() {
    userName = _userNameController.text; //the userName inserted by the user
    password = _passwordController.text; //the password inserted by the user
    login = new LoginProvider(loginCallBack);
    login.execute(userName, password);
  }

  void loginCallBack(bool isConnected, String token) {
    this.isConnected = isConnected;
    this._token = token;
    if (isConnected == true) {
      var route2 = new MaterialPageRoute(
        builder: (BuildContext context) => new SupplierHomePageScreen(
          token: _token,
        ),
      );
      Navigator.of(context).push(route2);
    } else
      showUserPasswordNotCorrect();
  } //setState

}
