import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';
import 'package:shopiana/view/screen/home/widget/home_products_widget.dart';

class NotificationScreenBottom extends StatelessWidget {
  const NotificationScreenBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => DashBoardScreen(),
                ),
                (route) => false)),
        title: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: HomeProducts(_scrollController),
          controller: _scrollController),
    );
  }
}
