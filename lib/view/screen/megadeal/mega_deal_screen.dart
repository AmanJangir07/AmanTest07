import 'package:flutter/material.dart';
import 'package:shopiana/provider/mega_deal_provider.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/string_resources.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:shopiana/view/basewidget/title_row.dart';
import 'package:provider/provider.dart';

class MegaDealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: Strings.mega_deal),
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: TitleRow(
              title: Strings.mega_deal,
              eventDuration: Provider.of<MegaDealProvider>(context).duration),
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: null
                //  MegaDealsView(isHomeScreen: false),
                )),
      ]),
    );
  }
}
