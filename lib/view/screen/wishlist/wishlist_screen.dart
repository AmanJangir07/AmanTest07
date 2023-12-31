import 'package:flutter/material.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/search_provider.dart';
import 'package:shopiana/provider/wishlist_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/view/basewidget/no_internet_screen.dart';
import 'package:shopiana/view/basewidget/not_loggedin_widget.dart';
import 'package:shopiana/view/basewidget/search_widget.dart';
import 'package:shopiana/view/screen/wishlist/widget/wishlist_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          SearchWidget(
            hintText: 'Search wishlist...',
            onTextChanged: (query) {
              Provider.of<WishListProvider>(context, listen: false)
                  .searchWishList(query);
            },
            onClearPressed: () {
              Provider.of<SearchProvider>(context, listen: false)
                  .setSearchText('');
            },
          ),
          Expanded(
            child: isGuestMode
                ? NotLoggedInWidget()
                : Consumer<WishListProvider>(
                    builder: (context, wishListProvider, child) {
                      return wishListProvider.wishList != null
                          ? wishListProvider.wishList.length != 0
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(0),
                                  itemCount: wishListProvider.wishList.length,
                                  itemBuilder: (context, index) =>
                                      WishListWidget(
                                    product: wishListProvider.wishList[index],
                                    index: index,
                                  ),
                                )
                              : NoInternetOrDataScreen(isNoInternet: false)
                          : WishListShimmer();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class WishListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: Provider.of<WishListProvider>(context).allWishList == null,
          child: ListTile(
            leading:
                Container(height: 50, width: 50, color: ColorResources.WHITE),
            title: Container(height: 20, color: ColorResources.WHITE),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 10, width: 70, color: ColorResources.WHITE),
                  Container(height: 10, width: 20, color: ColorResources.WHITE),
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
                ]),
            trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: ColorResources.WHITE)),
                  SizedBox(height: 10),
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
                ]),
          ),
        );
      },
    );
  }
}
