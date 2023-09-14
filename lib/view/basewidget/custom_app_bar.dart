import 'package:flutter/material.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final isBackButtonExist;
  final IconData? icon;
  final Function? onActionPressed;

  CustomAppBar(
      {required this.title,
      this.isBackButtonExist = true,
      this.icon,
      this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [
          isBackButtonExist
              ? IconButton(
                  icon: Icon(Icons.arrow_back, size: 20, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : SizedBox.shrink(),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Text(
              title!,
              style:
                  titilliumRegular.copyWith(fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          icon != null
              ? IconButton(
                  icon: Icon(icon,
                      size: Dimensions.ICON_SIZE_LARGE, color: Colors.white),
                  onPressed: onActionPressed as void Function()?,
                )
              : SizedBox.shrink(),
        ]),
      ),
    ]);
  }
}
