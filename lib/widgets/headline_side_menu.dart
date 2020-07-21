import 'package:flutter/cupertino.dart';
import 'package:food4good_app/utils/constants.dart';

class HeadlineSideMenu extends StatelessWidget {
  final String _headline;

  HeadlineSideMenu(this._headline);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Text(
          _headline,
          style: TextStyle(
              color: Constants.HEADLINE_COLOR,
              fontWeight: FontWeight.bold, fontSize: Constants.HEADLINE_SIZE),
        ),
      ),
    );
  }
}
