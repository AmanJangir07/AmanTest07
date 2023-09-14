import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/screen/auth/widget/sign_in_widget.dart';
import 'package:shopiana/view/screen/auth/widget/sign_up_widget.dart';

class MobileNumberWidget extends StatefulWidget {
  @override
  State<MobileNumberWidget> createState() => _MobileNumberWidgetState();
}

class _MobileNumberWidgetState extends State<MobileNumberWidget> {
  TextEditingController? _phoneNumberController;
  GlobalKey<FormState>? _formKeyLogin;
  bool isUserExist = false;
  bool isLoading = false;
  String initialCountry = 'IN';

  @override
  void initState() {
    _formKeyLogin = GlobalKey<FormState>();

    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController!.dispose();
    super.dispose();
  }

  FocusNode _phoneNumberNode = FocusNode();

  void checkIsUserExist() async {
    setState(() {
      isLoading = true;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();

      if (_phoneNumberController!.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        var response = await Provider.of<AuthProvider>(context, listen: false)
            .validateUserIsExist(
                context: context, userName: _phoneNumberController!.text);
        if (response != null) {
          setState(() {
            this.isUserExist =
                Provider.of<AuthProvider>(context, listen: false).isUserExist;
          });

          if (!this.isUserExist) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    SignUpWidget(_phoneNumberController!.text),
              ),
            );
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SignInWidget(_phoneNumberController!.text)));
          }
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKeyLogin,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            this.isUserExist
                ? InkWell(
                    onTap: () {
                      setState(() {
                        this.isUserExist = false;
                      });
                      print('on tap change');
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(
                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                          right: Dimensions.MARGIN_SIZE_DEFAULT,
                          bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                      child: Text(
                        getTranslated('Change', context)!,
                        style: TextStyle(
                          color: ColorResources.getBlue(context),
                        ),
                      ),
                    ),
                  )
                : Text(''),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                "Enter Mobile Number",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: _height * 0.03,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: _height * 0.025,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IntlPhoneField(
                  decoration: InputDecoration(
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(_width * 0.02)),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  flagsButtonPadding: EdgeInsets.all(_width * 0.02),
                  dropdownIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  initialCountryCode: initialCountry,
                  keyboardType: TextInputType.number,
                  focusNode: _phoneNumberNode,
                  controller: _phoneNumberController,
                  autofocus: true,
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                SizedBox(
                  width: _width * 0.9,
                  height: _height * 0.06,
                  child: ElevatedButton(
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            )
                          : Text(getTranslated('submit', context)!,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        checkIsUserExist();
                        /* setState(() {
                          isButtonLoading = false;
                        }); */
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
