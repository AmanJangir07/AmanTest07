import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/support_ticket_model.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/support_ticket_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/custom_expanded_app_bar.dart';
import 'package:shopiana/view/basewidget/no_internet_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'issue_type_screen.dart';

class SupportTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SupportTicketProvider>(context, listen: false)
        .getSupportTicketList();
    NetworkInfo.checkConnectivity(context);

    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      isGuestCheck: true,
      bottomChild: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => IssueTypeScreen())),
        child: Material(
          color: ColorResources.getColombiaBlue(context),
          elevation: 5,
          borderRadius: BorderRadius.circular(50),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: ColorResources.getFloatingBtn(context),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 35),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(getTranslated('new_ticket', context)!,
                  style: titilliumSemiBold.copyWith(
                      color: Colors.white,
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
          ]),
        ),
      ),
      child: Provider.of<SupportTicketProvider>(context).supportTicketList !=
              null
          ? Provider.of<SupportTicketProvider>(context)
                      .supportTicketList!
                      .length !=
                  0
              ? Consumer<SupportTicketProvider>(
                  builder: (context, support, child) {
                    List<SupportTicketModel> supportTicketList =
                        support.supportTicketList!.reversed.toList();
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                      itemCount: supportTicketList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          margin: EdgeInsets.only(
                              bottom: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            color: ColorResources.getImageBg(context),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorResources.getSellerTxt(context),
                                width: 2),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Place date: ${supportTicketList[index].createdAt}',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                Text(supportTicketList[index].subject!,
                                    style: titilliumSemiBold),
                                Row(children: [
                                  Icon(Icons.notifications,
                                      color: ColorResources.getPrimary(context),
                                      size: 20),
                                  SizedBox(
                                      width: Dimensions.PADDING_SIZE_SMALL),
                                  Expanded(
                                      child: Text(supportTicketList[index].type!,
                                          style: titilliumSemiBold)),
                                  ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          supportTicketList[index].status ==
                                                  'solved'
                                              ? ColorResources.getGreen(context)
                                              : Theme.of(context).primaryColor,
                                    ),
                                    child: Text(supportTicketList[index].status!,
                                        style: titilliumSemiBold.copyWith(
                                            color: Colors.white)),
                                  ),
                                ]),
                              ]),
                        );
                      },
                    );
                  },
                )
              : NoInternetOrDataScreen(isNoInternet: false)
          : SupportTicketShimmer(),
    );
  }
}

class SupportTicketShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: ColorResources.IMAGE_BG,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorResources.SELLER_TXT, width: 2),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled:
                Provider.of<SupportTicketProvider>(context).supportTicketList ==
                    null,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 10, width: 100, color: ColorResources.WHITE),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(height: 15, color: ColorResources.WHITE),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Row(children: [
                Container(height: 15, width: 15, color: ColorResources.WHITE),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Container(height: 15, width: 50, color: ColorResources.WHITE),
                Expanded(child: SizedBox.shrink()),
                Container(height: 30, width: 70, color: ColorResources.WHITE),
              ]),
            ]),
          ),
        );
      },
    );
  }
}
