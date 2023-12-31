import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/notification_model.dart';
import 'package:shopiana/data/repository/notification_repo.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo? notificationRepo;

  NotificationProvider({required this.notificationRepo});

  List<NotificationModel> _notificationList = [];

  List<NotificationModel> get notificationList => _notificationList;

  void initNotificationList() async {
    if (_notificationList.length == 0) {
      _notificationList.clear();
      _notificationList.addAll(notificationRepo!.getNotificationList());
      notifyListeners();
    }
  }
}
