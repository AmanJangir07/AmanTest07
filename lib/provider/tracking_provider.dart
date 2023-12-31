import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/tracking_model.dart';
import 'package:shopiana/data/repository/tracking_repo.dart';

class TrackingProvider extends ChangeNotifier {
  final TrackingRepo? trackingRepo;
  TrackingProvider({required this.trackingRepo});

  TrackingModel? _trackingModel;
  TrackingModel? get trackingModel => _trackingModel;

  void initTrackingInfo(String orderID) async {
    _trackingModel = trackingRepo!.getTrackingInfo();
    notifyListeners();
  }
}
