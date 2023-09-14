import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/brand_provider.dart';
import 'package:shopiana/provider/cart_provider.dart';
import 'package:shopiana/provider/category_provider.dart';
import 'package:shopiana/provider/chat_provider.dart';
import 'package:shopiana/provider/coupon_provider.dart';
import 'package:shopiana/provider/home_provider.dart';
import 'package:shopiana/provider/localization_provider.dart';
import 'package:shopiana/provider/master_provider.dart';
import 'package:shopiana/provider/mega_deal_provider.dart';
import 'package:shopiana/provider/notification_provider.dart';
import 'package:shopiana/provider/onboarding_provider.dart';
import 'package:shopiana/provider/order_provider.dart';
import 'package:shopiana/provider/payment_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/search_provider.dart';
import 'package:shopiana/provider/seller_provider.dart';
import 'package:shopiana/provider/splash_provider.dart';
import 'package:shopiana/provider/support_ticket_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/provider/tracking_provider.dart';
import 'package:shopiana/provider/wallet_provider.dart';
import 'package:shopiana/provider/wishlist_provider.dart';
import 'package:shopiana/service/navigation_service.dart';
import 'package:shopiana/theme/dark_theme.dart';
import 'package:shopiana/theme/light_theme.dart';
import 'package:shopiana/utill/app_constants.dart';
import 'package:shopiana/view/screen/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'provider/product_details_provider.dart';
import 'provider/banner_provider.dart';
import 'provider/product_provider.dart';

import 'package:shopiana/provider/app_config_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<AppConfigProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<MegaDealProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BrandProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<ProductDetailsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<SupportTicketProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TrackingProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PaymentProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<MasterProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WalletProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode!, language.countryCode));
    });
    return MaterialApp(
      title: 'Shopiana',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      navigatorKey: di.sl<NavigationService>().navigatorKey,
      home: SplashScreen(),
    );
  }
}
