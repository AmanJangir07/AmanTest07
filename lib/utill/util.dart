import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/string_resources.dart';

class Util {
  static String getDynamicDate(String inputDateTime) {
    var now = DateTime.now();
    var target = DateTime.parse(inputDateTime);
    // return '${DateFormat('dd LLL, yyyy').format(target)}';

    if (now.year == target.year &&
        now.month == target.month &&
        now.day == target.day) {
      return 'Today ${DateFormat.jms().format(target)}';
    } else if (now.year == target.year &&
        now.month == target.month &&
        now.day - 1 == target.day) {
      return 'Yesterday ${DateFormat.jms().format(target)}';
    } else {
      return '${DateFormat('dd LLL, yyyy').format(target)}';
    }
  }

  static Color paymentModeBackgroundColor(String? paymentMode) {
    if (paymentMode?.toLowerCase() == Strings.COD) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  static int getDiscountPercentage(double originalPrice, double finalPrice) {
    return ((originalPrice - finalPrice) / originalPrice * 100).toInt();
  }
}
