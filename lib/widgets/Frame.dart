import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/utils/constants.dart';

class Frame extends StatelessWidget {
  final String givenText;

  Frame(this.givenText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            child: Text(givenText),
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                color: Constants.FRAME_BG_COLOR,
                border: Border.all(color: Constants.FRAME_BORDER_COLOR),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Constants.ORDER_FRAME_SHADOW_COLOR,
                      offset: Offset(3.0, 3.0)),
                ])),
      ],
    );
  }
}
