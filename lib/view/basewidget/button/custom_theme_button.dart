import 'package:flutter/material.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:provider/provider.dart';

class CustomThemeButton extends StatelessWidget {
  final Function? onTap;
  final String? buttonText;
  CustomThemeButton({this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
      ),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1)), // changes position of shadow
            ],
            borderRadius: BorderRadius.circular(5)),
        child: Text(buttonText!,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).accentColor,
            )),
      ),
    );
  }
}
