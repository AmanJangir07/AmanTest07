import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  void navigateToRoute(String _route) {
    navigatorKey.currentState?.pushNamed(_route);
  }

  void removeAndNavigateToRoute(String _route) {
    navigatorKey.currentState?.pushNamed(_route);
  }

  void navigateToPage(Widget _page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (BuildContext _context) {
        return _page;
      }),
    );
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

  void pushAndRemoveUntil(Widget _page) {
    /* navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext _context) => _page),
        (route) => false); */
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext _context) => _page),
        (route) => false);
  }
}
