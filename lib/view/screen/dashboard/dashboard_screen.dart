import 'package:flutter/material.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/view/screen/category/all_category_screen.dart';
import 'package:shopiana/view/screen/dashboard/widget/fancy_bottom_nav_bar.dart';
import 'package:shopiana/view/screen/home/home_screen.dart';
import 'package:shopiana/view/screen/more/more_screen.dart';
import 'package:shopiana/view/screen/notification/notification_screen.dart';
import 'package:shopiana/view/screen/notificationScreen/notification_screen_bottom.dart';
import 'package:shopiana/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/product/product_screen.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final PageController _pageController = PageController();
  int _selectedPageIndex = 0;
  List<Widget> _screens = [];

  final GlobalKey<FancyBottomNavBarState> _bottomNavKey = GlobalKey();

  void setAllScreens(BuildContext context) {
    _screens = [
      HomePage(),
      if (Provider.of<SplashProvider>(context, listen: false)
          .configModel!
          .displayCategorySection!)
        AllCategoryScreen(),
      if (Provider.of<SplashProvider>(context, listen: false)
          .configModel!
          .displayProductSection!)
        ProductScreen(),

      NotificationScreenBottom(),

      // InboxScreen(isBackButtonExist: false),
      if (Provider.of<SplashProvider>(context, listen: false)
          .configModel!
          .displayOrderSection!)
        OrderScreen(isBacButtonExist: false),
      // NotificationScreen(isBacButtonExist: false),
      MoreScreen(),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      print("change index" + index.toString());
      _selectedPageIndex = index;
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    if (_selectedPageIndex != 0) {
      setState(() {
        _selectedPageIndex = 0;
      });
      return Future.value(false);
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        // Fluttertoast.showToast(msg: 'Press back again to exit');
        return Future.value(false);
      }
      return Future.value(true);
    }
  }

  @override
  void initState() {
    super.initState();
    setAllScreens(context);
  }

  @override
  Widget build(BuildContext context) {
    int _pageIndex;
    if (Provider.of<SplashProvider>(context, listen: false).fromSetting) {
      _pageIndex = 6;
    } else {
      _pageIndex = 0;
    }
    return Scaffold(
      body: WillPopScope(
          child: _screens[_selectedPageIndex], onWillPop: onWillPop),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).accentColor,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).focusColor,
        // selectedItemColor: Colors.pink,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          if (Provider.of<SplashProvider>(context, listen: false)
              .configModel!
              .displayCategorySection!)
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: "Category",
            ),
          if (Provider.of<SplashProvider>(context, listen: false)
              .configModel!
              .displayProductSection!)
            BottomNavigationBarItem(
              icon: Icon(Icons.bento_outlined),
              label: "Products",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_outlined),
            label: "Notifications",
          ),
          if (Provider.of<SplashProvider>(context, listen: false)
              .configModel!
              .displayOrderSection!)
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: "Orders",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Account",
          ),
        ],
      ),
      // CommonBottomNavigationBar(
      //   index: 0,
      // ),
      //     FancyBottomNavBar(
      //   key: _bottomNavKey,
      //   initialSelection: _pageIndex,
      //   isLtr: Provider.of<LocalizationProvider>(context).isLtr,
      //   isDark: Provider.of<ThemeProvider>(context).darkTheme,
      //   tabs: [
      //     FancyTabData(
      //         imagePath: Images.home_image,
      //         title: getTranslated('home', context)),
      //     // FancyTabData(
      //     //     imagePath: Images.message_image,
      //     //     title: getTranslated('inbox', context)),
      //     FancyTabData(
      //         imagePath: Images.shopping_image,
      //         title: getTranslated('orders', context)),
      //     // FancyTabData(
      //     //     imagePath: Images.notification,
      //     //     title: getTranslated('notification', context)),
      //     FancyTabData(
      //         imagePath: Images.more_image,
      //         title: getTranslated('more', context)),
      //   ],
      //   onTabChangedListener: (int index) {
      //     _pageController.jumpToPage(index);
      //     _pageIndex = index;
      //   },
      // ),
      // body: PageView.builder(
      //   controller: _pageController,
      //   itemCount: _screens.length,
      //   physics: NeverScrollableScrollPhysics(),
      //   itemBuilder: (context, index) {
      //     return _screens[_selectedPageIndex];
      //   },
      // ),
    );
  }
}
