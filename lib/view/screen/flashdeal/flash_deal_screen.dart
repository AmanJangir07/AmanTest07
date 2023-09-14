import 'package:flutter/material.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/mega_deal_provider.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:shopiana/view/basewidget/title_row.dart';
import 'package:shopiana/view/screen/home/widget/flash_deals_view.dart';
import 'package:provider/provider.dart';

class FlashDealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: getTranslated('flash_deal', context)),
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: TitleRow(
              title: getTranslated('flash_deal', context),
              eventDuration: Provider.of<MegaDealProvider>(context).duration),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: FlashDealsView(isHomeScreen: false),
        )),
      ]),
    );
  }
}
