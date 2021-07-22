import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class HelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: -40,
            left: -80,
            child: Transform(
              transform: Matrix4.rotationZ(pi / 12.0),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/leavesbg.svg",
                color: Color.fromRGBO(0, 0, 0, 0.06),
                height: 360,
                width: 360,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'How to scan items',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: black),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Place the item you want to scan on a surface with a quiet background.',
                    style: TextStyle(color: black),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    "The AI works best when the object is against a white background and place in the center.",
                    style: TextStyle(color: black),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    "Keep in mind that the AI is not perfect. It's meant to be an indicator and to assist in identification, not to make the final judgement.",
                    style: TextStyle(color: black),
                  ),
                  SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text(
                        'Close',
                        style: linkButtonStyle,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
