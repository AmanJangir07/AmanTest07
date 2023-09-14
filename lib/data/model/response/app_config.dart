class AppConfig {
  final bool? displayWishList;
  final bool? allowGuestUser;

  AppConfig({this.displayWishList, this.allowGuestUser});
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
        displayWishList: json['displayWishList'],
        allowGuestUser: json['allowGuestUser']);
  }
}
