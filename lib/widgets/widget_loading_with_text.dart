import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetLoadingWithText extends StatelessWidget {
  final String text;

  WidgetLoadingWithText(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.green,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
