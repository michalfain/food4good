import 'package:flutter/cupertino.dart';
import 'package:food4good_app/utils/constants.dart';

class HeadlineWidget extends StatelessWidget {
  final String _headline;

  HeadlineWidget(this._headline);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 5.0),
      ),
      Text(
        _headline,
        style: TextStyle(color: Constants.HEADLINE_COLOR, fontSize: Constants.HEADLINE_SIZE),
      ),
    ]);
  }
}
