import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:shopiana/view/basewidget/button/custom_theme_button.dart';
import 'package:shopiana/view/basewidget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/auth/auth_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

enum Steps {
  first_step,
  second_step,
  third_step,
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  Steps activeStep = Steps.first_step;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  void changeStep(Steps step) {
    setState(() {
      activeStep = step;
    });
  }

  onFirstStep(AuthProvider authProvider) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      isLoading = true;
    });
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red));
    } else {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      await authProvider.validateUserIsExist(
          userName: _controller.text, context: context);
      if (authProvider.isUserExist) {
        authProvider.generateResetOpt(
            context: context, userName: _controller.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(getTranslated('otp_sent_msg', context)!),
            backgroundColor: Colors.green));

        changeStep(Steps.second_step);
        // _controller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('User not exist'), backgroundColor: Colors.red));
      }

      // onValidateUserIsExist(int.parse(_controller.text));

    }
    setState(() {
      isLoading = false;
    });
  }

  onSecondStep(AuthProvider authProvider) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      isLoading = true;
    });
    bool otpresponse;
    if (_otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('OTP_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red));
    } else {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      otpresponse = await authProvider.validateResetOtp(
          context: context,
          username: _controller.text,
          otp: _otpController.text);
      if (otpresponse) {
        changeStep(Steps.third_step);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Enter New Pin"), backgroundColor: Colors.green));
      } /*  else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please enter Valid Otp"),
            backgroundColor: Colors.red));
      } */

      // onValidateUserIsExist(int.parse(_controller.text));
    }
    setState(() {
      isLoading = false;
    });
  }

  onThirdStep(AuthProvider authProvider) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      isLoading = true;
    });
    var response;
    if (_pinController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red));
    } else if (_repeatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red));
    } else if (_pinController.text != _repeatController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password not matched"), backgroundColor: Colors.red));
    } else {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      response = await authProvider.resetUserPin(
          otp: _otpController.text,
          pin: _pinController.text,
          repeatPin: _repeatController.text,
          username: _controller.text);
      // onValidateUserIsExist(int.parse(_controller.text));
      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Password changed successfully'),
            backgroundColor: Colors.green));
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => AuthScreen()), (route) => false);
        /*  Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AuthScreen()),
        ); */
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red));
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
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    // void onValidateUserIsExist(int userName) async {
    //   bool isUserExist;
    //   isUserExist = await authProvider.validateUserIsExist(userName);
    //   if (isUserExist) {
    //     showCustomSnackBar(getTranslated('otp_sent_msg', context), context);
    //   } else {
    //   }
    // }

    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      key: _key,
      bottomNavigationBar: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomThemeButton(
            buttonText: isLoading
                ? 'Loading...'
                : (activeStep != Steps.third_step)
                    ? getTranslated('continue', context)
                    : getTranslated('submit', context),
            onTap: isLoading
                ? null
                : () {
                    switch (activeStep) {
                      case Steps.first_step:
                        onFirstStep(authProvider);
                        break;
                      case Steps.second_step:
                        onSecondStep(authProvider);
                        break;
                      case Steps.third_step:
                        onThirdStep(authProvider);
                        break;
                      default:
                    }

                    // showCustomSnackBar(
                    //     getTranslated('otp_sent_msg', context),
                    //     context);

                    //   showAnimatedDialog(
                    //       context,
                    //       MyDialog(
                    //         icon: Icons.send,
                    //         title: getTranslated('sent', context),
                    //         description:
                    //             getTranslated('otp_sent_msg', context),
                    //         rotateAngle: 5.5,
                    //       ),
                    //       dismissible: false);
                  },
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            SafeArea(
                child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () {
                    if (activeStep == Steps.first_step) {
                      Navigator.pop(context);
                    } else if (activeStep == Steps.second_step) {
                      changeStep(Steps.first_step);
                    } else if (activeStep == Steps.third_step) {
                      changeStep(Steps.second_step);
                    }
                  }),
            )),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(50),
                      child: Image.asset(
                        Images.LOGO,
                        height: _height * 0.15,
                        width: _height * 0.15,
                        // color: ColorResources.getPrimary(context),
                      ),
                    ),
                    Text(getTranslated('FORGET_PASSWORD', context)!,
                        style: titilliumSemiBold),
                    // Text(
                    //     getTranslated(
                    //         'enter_your_registered_mobile_number', context),
                    //     style: titilliumRegular.copyWith(
                    //         color: Theme.of(context).hintColor,
                    //         fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    if (Steps.first_step == activeStep)
                      CustomTextField(
                        controller: _controller,
                        isPhoneNumber: true,
                        labeltext:
                            getTranslated('enter_mobile_number', context),
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                      ),
                    if (Steps.second_step == activeStep)
                      Column(
                        children: [
                          SizedBox(
                            width: _width * 0.6,
                            child: Text(
                              "Enter the Otp code sent to you at " +
                                  _controller.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: _height * 0.023,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.08,
                          ),
                          PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 6) {
                                return "Enter Otp Code";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: _width * 0.14,
                                activeFillColor: Colors.transparent,
                                selectedFillColor: Colors.transparent,
                                selectedColor: Colors.black,
                                activeColor: Theme.of(context).primaryColor,
                                inactiveFillColor: Colors.transparent,
                                inactiveColor: Theme.of(context).primaryColor),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onChanged: (String value) {},
                            // onTap: () {
                            //   print("Pressed");
                            // },
                          ),
                        ],
                      ),
                    /* CustomTextField(
                        controller: _otpController,
                        labeltext: getTranslated('enter_otp', context),
                        hintText: getTranslated('enter_otp', context),
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                      ), */
                    if (Steps.third_step == activeStep)
                      Column(
                        children: [
                          CustomTextField(
                            controller: _pinController,
                            labeltext: getTranslated('PASSWORD', context),
                            hintText: getTranslated('PASSWORD', context),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: _repeatController,
                            labeltext:
                                getTranslated('RE_ENTER_PASSWORD', context),
                            hintText:
                                getTranslated('RE_ENTER_PASSWORD', context),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.number,
                          ),
                        ],
                      ),

                    SizedBox(height: 50),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
