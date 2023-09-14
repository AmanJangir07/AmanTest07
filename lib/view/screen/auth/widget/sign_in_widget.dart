import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopiana/data/model/body/login_model.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/view/screen/auth/forget_password_screen.dart';

class SignInWidget extends StatefulWidget {
  String userName;
  SignInWidget(this.userName);
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  //TextEditingController _phoneNumberController;

  TextEditingController? _pinController;

  GlobalKey<FormState>? _formKeyLogin;

  bool isUserExist = false;
  bool isLoading = false;
  String initialCountry = 'IN';

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();

//_phoneNumberController = TextEditingController();
    _pinController = TextEditingController();

    /* //_phoneNumberController.text =
        Provider.of<AuthProvider>(context, listen: false).getUserEmail() ??
            null; */
    _pinController!.text =
        Provider.of<AuthProvider>(context, listen: false).getUserPassword();
  }

  @override
  void dispose() {
    // _phoneNumberController.dispose();
    _pinController!.dispose();
    super.dispose();
  }

  // FocusNode _phoneNumberNode = FocusNode();
  FocusNode _pinNode = FocusNode();
  LoginModel loginBody = LoginModel();

  /* void checkIsUserExist() async {
    setState(() {
      isLoading = true;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (_formKeyLogin.currentState.validate()) {
      _formKeyLogin.currentState.save();

      if (_phoneNumberController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        var response = await Provider.of<AuthProvider>(context, listen: false)
            .validateUserIsExist(_phoneNumberController.text);
        if (response != null) {
          setState(() {
            this.isUserExist =
                Provider.of<AuthProvider>(context, listen: false).isUserExist;
          });

          if (!this.isUserExist) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUpWidget(_phoneNumberController.text),
              ),
            );
          }
          //  else {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) =>
          //           AuthPinScreen(username: _phoneNumberController.text),
          //     ),
          //   );
          // }
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  } */

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();

      /*   if (_phoneNumberController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)),
          backgroundColor: Colors.red,
        ));
      } else  */
      if (_pinController!.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else {
        /* if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
          Provider.of<AuthProvider>(context, listen: false)
              .saveUserEmail(_phoneNumberController.text, _pinController.text);
        } else { */
        Provider.of<AuthProvider>(context, listen: false)
            .clearUserEmailAndPassword();
      }

      loginBody.username = widget.userName;
      loginBody.password = _pinController!.text;
      await Provider.of<AuthProvider>(context, listen: false)
          .login(loginBody, context);

      // Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
      /* bool isLoggedIn =
          Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      if (isLoggedIn) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Logged In!!"),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => DashBoardScreen(),
            ),
            (route) => false);
      } */
      // else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(getTranslated('something_went_wrong', context)),
      //     backgroundColor: Colors.red,
      //   ));
      // }
      //}
      /*      if (Provider.of<AuthProvider>(context, listen: false).appException !=
              null &&
          isLoggedIn == false) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(Provider.of<AuthProvider>(context, listen: false)
              .appException
              .message),
          backgroundColor: Colors.red,
        ));
      } */
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
            key: _formKeyLogin,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.2,
                  ),
                  /* this.isUserExist
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
                              getTranslated('Change', context),
                              style: TextStyle(
                                color: ColorResources.getBlue(context),
                              ),
                            ),
                          ),
                        )
                      : Text(''), */
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      "Enter your 4 digit PIN",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: _height * 0.03,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.001,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /* Column(
                        children: [
                          IntlPhoneField(
                            initialCountryCode: initialCountry,
                            focusNode: _phoneNumberNode,
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              labelText:
                                  getTranslated('enter_mobile_number', context),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          this.isUserExist
                              ? 
                              : Text(''),
                        ],
                      ), */
                      /* Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: CustomPasswordTextField(
                            labelText:
                                getTranslated('ENTER_YOUR_PASSWORD', context),
                            focusNode: _pinNode,
                            // nextNode: _pinNode,
                            controller: _pinController,
                          ),
                        ),
                      ), */
                      Padding(
                          padding: EdgeInsets.all(_width * 0.12),
                          child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 4,
                              autoFocus: true,
                              obscureText: true,
                              obscuringCharacter: '*',
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 3) {
                                  return "Enter Pass Code";
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
                                  inactiveColor:
                                      Theme.of(context).primaryColor),
                              cursorColor: Colors.black,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              controller: _pinController,
                              keyboardType: TextInputType.number,
                              boxShadows: const [],
                              onCompleted: (v) {
                                debugPrint("Completed");
                              },
                              // onTap: () {
                              //   print("Pressed");
                              // },
                              onChanged: (value) {
                                print(value);
                              })),
                      SizedBox(
                        height: _height * 0.05,
                      ),
                      SizedBox(
                        width: _width * 0.9,
                        height: _height * 0.06,
                        child: ElevatedButton(
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Text(
                                    getTranslated('submit', context)!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              loginUser();
                            }),
                      ),
                      SizedBox(
                        height: _height * 0.05,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ForgetPasswordScreen()));
                        },
                        child: Text(
                          "Forgot Password",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
