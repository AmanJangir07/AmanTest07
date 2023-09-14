import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopiana/data/model/body/register_model.dart';
import 'package:shopiana/data/model/response/user_info_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/constants.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/store_constant.dart';
import 'package:shopiana/view/basewidget/button/custom_button.dart';
import 'package:shopiana/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:shopiana/view/basewidget/textfield/custom_textfield.dart';
import 'package:shopiana/view/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

enum Steps {
  OTP_STEP,
  PIN_STEP,
  USER_STEP,
}

class SignUpWidget extends StatefulWidget {
  final String mobileNumber;

  SignUpWidget(this.mobileNumber);
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  GlobalKey<FormState>? _formKey;

  FocusNode _fNameFocus = FocusNode();
  FocusNode _lNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();
  FocusNode _otpFocus = FocusNode();

  Steps activeStepIndex = Steps.OTP_STEP;
  bool isOtpValid = false;
  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  RegisterModel register = RegisterModel();
  Group group = Group();
  bool isEmailVerified = false;
  UserBilling ubilling = UserBilling();
  UserBilling udelivery = UserBilling();

  void generateOtp(BuildContext context) {
    if (widget.mobileNumber.isNotEmpty) {
      var response =
          Provider.of<AuthProvider>(context, listen: false).genrateOtp(
        mobileNumber: widget.mobileNumber,
      );
      if (response != null) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(getTranslated('otp_generated_successfully', context)),
        //     backgroundColor: Colors.green,
        //   ),
        // );
      }
    }
  }

  // validate user otp
  validateOtp({String? otp, String? mobileNumber}) async {
    var response =
        await Provider.of<AuthProvider>(context, listen: false).validateOtp(
      mobileNumber: widget.mobileNumber,
      otp: _otpController.text,
    );
    if (response != null) {
      setState(() {
        isOtpValid = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_phoneController.text +
              getTranslated('mobile_number_is_Verified', context)!),
          backgroundColor: Colors.green,
        ),
      );
      // changeButtonText(Constants.BTN_TEXT_SUBMIT);
      // changeActiveStep(Steps.PIN_STEP);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated('Otp_incorrect', context)!),
        backgroundColor: Colors.red,
      ));
    }
  }

  addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      isEmailVerified = true;

      if (_firstNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_lastNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('LAST_NAME_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
          backgroundColor: Colors.red,
        ));
      } else {
        group.name = Constants.CUSTOMER_ROLE;
        group.type = Constants.CUSTOMER_ROLE;

        register.firstName = '${_firstNameController.text}';
        register.lastName = _lastNameController.text;
        register.password = _passwordController.text;
        register.repeatPassword = _confirmPasswordController.text;
        register.storeCode = StoreConstant.STORE_CODE;
        register.userName = _phoneController.text;
        setState(() {
          _isLoadingButton = true;
        });
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.registration(register);
        if (authProvider.getUserToken().isNotEmpty) {}
        Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoardScreen()));

        // _emailController.clear();
        _passwordController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _phoneController.clear();
        _confirmPasswordController.clear();
        setState(() {
          _isLoadingButton = false;
        });
      }
    } else {
      isEmailVerified = false;
    }
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        setState(() {
          _enableButton = false;
          _isLoadingButton = true;
        });
        validateOtp();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        setState(() {
          _enableButton = true;
          _isLoadingButton = false;
        });
      } else {
        _enableButton = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    generateOtp(context);
    _phoneController.text = widget.mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: Dimensions.MARGIN_SIZE_SMALL,
            top: Dimensions.MARGIN_SIZE_SMALL),
        child: _isLoadingButton
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : CustomButton(
                onTap: () {
                  isOtpValid ? addUser() : validateOtp();
                },
                buttonText:
                    isOtpValid ? getTranslated('SIGN_UP', context) : "Proceed"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        children: [
          !isOtpValid
              ? /* Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_DEFAULT,
                      right: Dimensions.MARGIN_SIZE_DEFAULT,
                      top: Dimensions.MARGIN_SIZE_SMALL),
                  child: CustomTextField(
                    textInputType: TextInputType.number,
                    hintText: "Enter otp",
                    focusNode: _otpFocus,
                    controller: _otpController,
                    isPhoneNumber: true,
                  ),
                ) */

              Column(
                  children: [
                    Text(
                      "Verify Your Account",
                      style: TextStyle(
                          fontSize: _height * 0.023,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    SizedBox(
                      width: _width * 0.6,
                      child: Text(
                        "Enter the Otp code sent to you at " +
                            _phoneController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _height * 0.023,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: _width * 0.02, right: _width * 0.02),
                      child: Container(
                        child: PinCodeTextField(
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
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              _onOtpCallBack(value, false);
                            }),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: _height * 0.025,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: _height * 0.07,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // for first and last name
                          Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.MARGIN_SIZE_DEFAULT,
                                right: Dimensions.MARGIN_SIZE_DEFAULT),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomTextField(
                                  labeltext:
                                      getTranslated('FIRST_NAME', context),
                                  textInputType: TextInputType.name,
                                  focusNode: _fNameFocus,
                                  nextNode: _lNameFocus,
                                  isPhoneNumber: false,
                                  controller: _firstNameController,
                                )),
                                SizedBox(width: 15),
                                Expanded(
                                  child: CustomTextField(
                                    labeltext:
                                        getTranslated('LAST_NAME', context),
                                    focusNode: _lNameFocus,
                                    nextNode: _emailFocus,
                                    controller: _lastNameController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.02,
                          ),
                          // for email
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       left: Dimensions.MARGIN_SIZE_DEFAULT,
                          //       right: Dimensions.MARGIN_SIZE_DEFAULT,
                          //       top: Dimensions.MARGIN_SIZE_SMALL),
                          //   child: CustomTextField(
                          //     hintText: getTranslated('ENTER_YOUR_EMAIL', context),
                          //     focusNode: _emailFocus,
                          //     nextNode: _phoneFocus,
                          //     textInputType: TextInputType.emailAddress,
                          //     controller: _emailController,
                          //   ),
                          // ),

                          // for phone

                          Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.MARGIN_SIZE_DEFAULT,
                                right: Dimensions.MARGIN_SIZE_DEFAULT,
                                top: Dimensions.MARGIN_SIZE_SMALL),
                            child: CustomTextField(
                              textInputType: TextInputType.number,
                              labeltext:
                                  getTranslated('ENTER_MOBILE_NUMBER', context),
                              focusNode: _phoneFocus,
                              nextNode: _passwordFocus,
                              controller: _phoneController,
                              readOnly: true,
                              isPhoneNumber: true,
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.02,
                          ),
                          // for password
                          Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.MARGIN_SIZE_DEFAULT,
                                right: Dimensions.MARGIN_SIZE_DEFAULT,
                                top: Dimensions.MARGIN_SIZE_SMALL),
                            child: CustomPasswordTextField(
                              labelText: getTranslated('PASSWORD', context),
                              focusNode: _passwordFocus,
                              nextNode: _confirmPasswordFocus,
                              controller: _passwordController,
                            ),
                            //  CustomPasswordTextField(
                            //   hintTxt: getTranslated('PASSWORD', context),
                            //   controller: _passwordController,
                            //   focusNode: _passwordFocus,
                            //   nextNode: _confirmPasswordFocus,
                            //   textInputAction: TextInputAction.next,
                            // ),
                          ),
                          SizedBox(
                            height: _height * 0.02,
                          ),
                          // for re-enter password
                          Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.MARGIN_SIZE_DEFAULT,
                                right: Dimensions.MARGIN_SIZE_DEFAULT,
                                top: Dimensions.MARGIN_SIZE_SMALL),
                            child: CustomPasswordTextField(
                              labelText:
                                  getTranslated('RE_ENTER_PASSWORD', context),
                              focusNode: _confirmPasswordFocus,
                              controller: _confirmPasswordController,
                              textInputAction: TextInputAction.done,
                            ),
                            // CustomPasswordTextField(
                            //   hintTxt: getTranslated('RE_ENTER_PASSWORD', context),
                            //   controller: _confirmPasswordController,
                            //   focusNode: _confirmPasswordFocus,
                            //   textInputAction: TextInputAction.done,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          // for register button

          // for skip for now
          /* Center(
              child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => DashBoardScreen()));
            },
            child: Text(getTranslated('SKIP_FOR_NOW', context),
                style: titilliumRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).primaryColor)),
          )), */
        ],
      ),
    );
  }
}
