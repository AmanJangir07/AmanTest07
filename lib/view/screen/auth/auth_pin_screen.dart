import 'package:flutter/material.dart';
import 'package:shopiana/view/basewidget/textfield/custom_textfield.dart';

class AuthPinScreen extends StatelessWidget {
  final String username;
  const AuthPinScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: _height * 0.1,
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Enter your four digit pin",
              style: TextStyle(
                  fontSize: _height * 0.05, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: _height * 0.01,
          ),
          Container(
            width: _width * 0.8,
            // height: _height * 0.05,
            child: CustomTextField(
              hintText: "Enter your four digit pin",
              textInputType: TextInputType.phone,
            ),
          )
        ],
      ),
    );
  }
}
