import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/utils/constants.dart';

class RectangleFrame extends StatelessWidget {
  final String givenText;

  RectangleFrame(this.givenText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              child: Text(givenText),
              padding:
                  EdgeInsets.only(left: 50.0, top: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Constants.RECTANGLE_FRAME_COLOR,
                  border: Border.all(color: Constants.RECTANGLE_FRAME_BORDER_COLOR),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Constants.RECTANGLE_FRAME_SHADOW_COLOR,
                        offset: Offset(3.0, 3.0)),
                  ])),
        ),
      ],
    );
  }
}
