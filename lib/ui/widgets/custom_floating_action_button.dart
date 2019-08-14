import 'package:flutter/material.dart';
import 'package:restorder/utils/uidata.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback qrCallback;
  final isMini;

  CustomFloatingActionButton({this.icon, this.qrCallback, this.isMini = false});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      mini: isMini,
      onPressed: qrCallback,
      child: Ink(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: UIData.gradientsFloatingActionButton)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.orangeAccent,
            )
          ],
        ),
      ),
    );
  }
}
