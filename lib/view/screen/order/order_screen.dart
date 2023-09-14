import 'package:flutter/material.dart';
import 'package:shopiana/data/enum_constants/order_enum.dart';
import 'package:shopiana/data/model/response/config_model.dart';
import 'package:shopiana/data/model/response/order_model.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/order_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/screen/cart/cart_screen.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';
import 'package:shopiana/view/screen/more/widget/loading_widget.dart';
import 'package:shopiana/view/screen/order/widget/my_order_list_tile.dart';
import 'package:shopiana/view/screen/order/widget/order_filter_options.dart';
import 'package:shopiana/view/screen/order/widget/order_shimmer.dart';
import 'package:shopiana/view/screen/order/widget/order_widget.dart';
import 'package:shopiana/view/screen/orderDetails/order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  final bool isBacButtonExist;

  OrderScreen({this.isBacButtonExist = true});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollController = new ScrollController();

  bool isFirstTime = true;
  int _page = 0;
  bool _isLoading = false;
  bool _isPageLoading = false;
  dynamic _selectedOrderStatus = OrderStatus.ALL;

  Future<void> getOrders({int? pageNumber}) async {
    setState(() {
      _isLoading = true;
      if (isFirstTime) {
        _isPageLoading = true;
      }
    });
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);
    await orderProvider.getOrders(
        context: context,
        pageNumber: pageNumber,
        orderStatus: _selectedOrderStatus['value'],
        count: Constants.DEFAULT_COUNT);

    setState(() {
      _isLoading = false;
      if (isFirstTime) {
        _isPageLoading = false;
        isFirstTime = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("init");
    getOrders(pageNumber: _page);
    // print("position" + _scrollController.position.pixels.toString());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("position" + _scrollController.position.pixels.toString());
        // orderProvider.setLoadingState(LoadMoreStatus.LOADING);
        getOrders(pageNumber: ++_page);
      }
    });
  }

  Future<void> orderFilter({dynamic selectedOrderStatus}) async {
    setState(() {
      print("_ispageloading: " + _isPageLoading.toString());
      _isPageLoading = true;
    });
    _selectedOrderStatus = selectedOrderStatus;
    _page = 0;
    await Provider.of<OrderProvider>(context, listen: false).getOrders(
        context: context,
        pageNumber: _page,
        orderStatus: _selectedOrderStatus['value'],
        count: Constants.DEFAULT_COUNT);
    setState(() {
      print("_ispageloading: " + _isPageLoading.toString());
      _isPageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    ConfigModel config =
        Provider.of<SplashProvider>(context, listen: false).configModel!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        title: Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => DashBoardScreen(),
                ),
                (route) => false)),
        actions: [
          config.allowOnlinePurchase!
              ? Consumer<CartProvider>(builder: (_, cart, ch) {
                  return IconButton(
                    onPressed: () {
                      // if (cart.cartItems.isNotEmpty) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CartScreen()));
                      // }
                    },
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          Images.cart_image,
                          color: Theme.of(context).primaryColor,
                          height: Dimensions.ICON_SIZE_DEFAULT,
                          width: Dimensions.ICON_SIZE_DEFAULT,
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(cart.cartItems.length.toString(),
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.WHITE,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                )),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              : SizedBox()
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: !Provider.of<AuthProvider>(context, listen: false).isLoggedIn()
          ? Center(
              child: Text("Please Login to see orders."),
            )
          : SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // SliverAppBar(
                  //   backgroundColor: Theme.of(context).primaryColor,
                  //   title: const Text('My Orders'),
                  //   centerTitle: true,
                  //   // floating: true,
                  // ),
                  SliverToBoxAdapter(
                    child: Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Orders: ${_selectedOrderStatus['title']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        return await orderFilterOptions(
                                            context: context,
                                            selectedStatus:
                                                _selectedOrderStatus,
                                            height: _height,
                                            width: _width,
                                            orderFilterCallbackFunction:
                                                orderFilter);
                                      },
                                      child: Row(
                                        children: [
                                          Text("Filter"),
                                          Icon(Icons.keyboard_arrow_down)
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor),
                                    )
                                  ],
                                ),
                              ),
                              _isPageLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ))
                                  : orderProvider.orders.length == 0 &&
                                          !_isLoading
                                      ? Center(
                                          child: Text("No orders available"),
                                        )
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              orderProvider.orders.length,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return OrderWidget(
                                              order:
                                                  orderProvider.orders[index],
                                            );
                                          }),
                              if (orderProvider.orders.length <
                                      orderProvider.totalOrders &&
                                  !_isPageLoading)
                                Center(child: AppLoadingIndicator())
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
