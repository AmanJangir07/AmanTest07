import 'package:shopiana/data/model/response/tracking_model.dart';
import 'package:shopiana/utill/app_constants.dart';

class TrackingRepo {
  TrackingModel getTrackingInfo() {
    TrackingModel trackingModel = TrackingModel(
        id: 1,
        customerId: '1',
        customerType: 'user',
        paymentStatus: 'pending',
        orderStatus: AppConstants.DELIVERED,
        orderAmount: '10000',
        shippingAddress: 'Dhaka, Bangladesh',
        discountAmount: '1000',
        discountType: 'percent');
    return trackingModel;
  }
}
