import 'package:flutter/material.dart';
import 'package:restorder/utils/translations.dart';

class AboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: FlutterLogo(
        colors: Colors.yellow,
      ),
      icon: FlutterLogo(
        colors: Colors.yellow,
      ),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Developed By Flutter Tutorial",
        ),
      ],
      applicationName: Translations.of(context).text("app_name"),
      applicationVersion: "1.0.1",
      applicationLegalese: "Apache License 2.0",
    );
  }
}
