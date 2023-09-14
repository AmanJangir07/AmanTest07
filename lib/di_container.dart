import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopiana/data/repository/app_config_repo.dart';
import 'package:shopiana/data/repository/home_repo.dart';
import 'package:shopiana/data/repository/master_repo.dart';
import 'package:shopiana/data/repository/payment_repo.dart';
import 'package:shopiana/data/repository/wallet_repo.dart';
import 'package:shopiana/helper/api_base_helper.dart';
import 'package:shopiana/provider/app_config_provider.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/banner_provider.dart';
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
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/provider/product_provider.dart';
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

import 'data/repository/auth_repo.dart';
import 'data/repository/banner_repo.dart';
import 'data/repository/brand_repo.dart';
import 'data/repository/cart_repo.dart';
import 'data/repository/category_repo.dart';
import 'data/repository/chat_repo.dart';
import 'data/repository/coupon_repo.dart';
import 'data/repository/mega_deal_repo.dart';
import 'data/repository/notification_repo.dart';
import 'data/repository/onboarding_repo.dart';
import 'data/repository/order_repo.dart';
import 'data/repository/product_details_repo.dart';
import 'data/repository/product_repo.dart';
import 'data/repository/profile_repo.dart';
import 'data/repository/search_repo.dart';
import 'data/repository/seller_repo.dart';
import 'data/repository/splash_repo.dart';
import 'data/repository/support_ticket_repo.dart';
import 'data/repository/tracking_repo.dart';
import 'data/repository/wishlist_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton(() => AppConfigRepo());
  sl.registerLazySingleton(() => CategoryRepo());
  sl.registerLazySingleton(() => MegaDealRepo());
  sl.registerLazySingleton(() => BrandRepo());
  sl.registerLazySingleton(() => ProductRepo());
  sl.registerLazySingleton(() => BannerRepo());
  sl.registerLazySingleton(() => OnBoardingRepo());
  sl.registerLazySingleton(
      () => AuthRepo(sharedPreferences: sl(), apiBaseHelper: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo());
  sl.registerLazySingleton(() =>
      SearchRepo(sharedPreferences: sl(), apiBaseHelper: sl(), authRepo: sl()));
  sl.registerLazySingleton(() => OrderRepo(apiBaseHelper: sl()));
  sl.registerLazySingleton(() => SellerRepo());
  sl.registerLazySingleton(
      () => CouponRepo(sharedPreferences: sl(), apiBaseHelper: sl()));
  sl.registerLazySingleton(() => ChatRepo());
  sl.registerLazySingleton(() => NotificationRepo());
  sl.registerLazySingleton(
      () => ProfileRepo(sharedPreferences: sl(), apiBaseHelper: sl()));
  sl.registerLazySingleton(() => WishListRepo());
  sl.registerLazySingleton(() =>
      CartRepo(sharedPreferences: sl(), apiBaseHelper: sl(), authRepo: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SupportTicketRepo());
  sl.registerLazySingleton(() => TrackingRepo());
  sl.registerLazySingleton(() => ApiBaseHelper());
  sl.registerLazySingleton(() => PaymentRepo(apiBaseHelper: sl()));
  sl.registerLazySingleton(() => MasterRepo(apiBaseHelper: sl()));
  sl.registerLazySingleton(
      () => WalletRepo(apiBaseHelper: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => HomeRepo(sharedPreferences: sl(), apiBaseHelper: sl()));
  sl.registerLazySingleton(() => NavigationService());
  // Provider
  sl.registerFactory(() => AppConfigProvider(sharedPreferences: sl()));
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(() => MegaDealProvider(megaDealRepo: sl()));
  sl.registerFactory(() => BrandProvider(brandRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl(), cartRepo: sl()));
  sl.registerFactory(() => ProductDetailsProvider(productDetailsRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => OrderProvider(orderRepo: sl(), authRepo: sl()));
  sl.registerFactory(() => SellerProvider(sellerRepo: sl()));
  sl.registerFactory(() => CouponProvider(couponRepo: sl(), cartRepo: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => WishListProvider(wishListRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl(), authRepo: sl()));
  sl.registerFactory(() => SupportTicketProvider(supportTicketRepo: sl()));
  sl.registerFactory(() => TrackingProvider(trackingRepo: sl()));
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => MasterProvider(masterRepo: sl(), authRepo: sl()));
  sl.registerFactory(() => HomeProvider(homeRepo: sl(), authRepo: sl()));
  sl.registerFactory(
      () => PaymentProvider(paymentRepo: sl(), authRepo: sl(), cartRepo: sl()));
  sl.registerFactory(() => WalletProvider(walletRepo: sl(), authRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
