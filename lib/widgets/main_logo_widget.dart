import 'package:flutter/cupertino.dart';
import 'package:food4good_app/utils/constants.dart';

class MainLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 55, maxWidth: 200),
        child: Image(
      image: AssetImage(Constants.IMG_LOGO),
    ));
  }
}
