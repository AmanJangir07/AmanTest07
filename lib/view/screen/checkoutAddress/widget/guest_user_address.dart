import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/data/model/body/country_master_model.dart';
import 'package:shopiana/data/model/body/state_master_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/master_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/button/custom_button.dart';
import 'package:shopiana/view/basewidget/show_custom_snakbar.dart';
import 'package:shopiana/view/basewidget/textfield/custom_textfield.dart';
import 'package:shopiana/view/screen/checkoutAddress/widget/update_auth_user_address.dart';
import 'package:shopiana/view/screen/checkoutPayment/checkout_payment_screen.dart';

class GuestUserAddress extends StatefulWidget {
  const GuestUserAddress({Key? key}) : super(key: key);

  @override
  State<GuestUserAddress> createState() => _GuestUserAddressState();
}

class _GuestUserAddressState extends State<GuestUserAddress> {
  UserProfile? guestUserAddress;
  final FocusNode _buttonAddressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailAddressFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _userCountryCode;
  String? _userStateCode;

  CountryMasterModel? selectedCountry;
  StateMasterModel? selectedState;
  List<StateMasterModel> allState = [];
  UserProfile? userProfile;
  bool _isLoading = false;

  Future<void> getCountries(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<MasterProvider>(context, listen: false).fetchCountries();
    List<CountryMasterModel> countries =
        await Provider.of<MasterProvider>(context, listen: false).countries;
    countries.forEach((country) {
      if (country.code == _userCountryCode) {
        selectedCountry = country;
      }
    });

    if (selectedCountry != null) {
      await getState(context, selectedCountry!.code);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getState(BuildContext context, String? countryCode) async {
    setState(() {
      _isLoading = true;
    });
    allState = await Provider.of<MasterProvider>(context, listen: false)
        .fetchAndGetStates(countryCode);

    allState.forEach((state) {
      if (state.code == _userStateCode) {
        selectedState = state;
      }
    });

    print("selectedState" + selectedState.toString());
    setState(() {
      _isLoading = false;
    });
  }

  initGuestUser() {
    guestUserAddress = Provider.of<ProfileProvider>(context, listen: false)
        .getSharePreferGuestUserAddress();

    if (guestUserAddress != null) {
      _firstNameController.text = guestUserAddress!.billing!.firstName!;
      _lastNameController.text = guestUserAddress!.billing!.lastName!;
      _phoneController.text = guestUserAddress!.billing!.phone!;
      _addressController.text = guestUserAddress!.billing!.address!;
      _cityNameController.text = guestUserAddress!.billing!.city!;
      _zipCodeController.text = guestUserAddress!.billing!.postalCode!;
      _emailController.text = guestUserAddress!.emailAddress!;
      _userCountryCode = guestUserAddress!.billing!.countryCode;
      _userStateCode = guestUserAddress!.billing!.zone;
    }
    print("guest user addrss" +
        guestUserAddress!.billing!.countryCode.toString());
  }

  _updateUserAddress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // isEmailVerified = true;

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
      } else if (_addressController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('ADDRESS_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_cityNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('CITY_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_zipCodeController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('ZIPCODE_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else {
        var data = {
          "billing": {
            "address": _addressController.text,
            "billingAddress": true,
            "billingGstNumber": "",
            "city": _cityNameController.text,
            "company": "",
            "country": selectedCountry!.code,
            "countryCode": selectedCountry!.code,
            "firstName": _firstNameController.text,
            "lastName": _lastNameController.text,
            "latitude": "",
            "longitude": "",
            "phone": _phoneController.text,
            "postalCode": _zipCodeController.text,
            "stateProvince": selectedState!.name,
            "zone": selectedState!.code
          },
          "delivery": {
            "address": _addressController.text,
            "billingAddress": true,
            "billingGstNumber": "",
            "city": _cityNameController.text,
            "company": "",
            "country": selectedCountry!.code,
            "countryCode": selectedCountry!.code,
            "firstName": _firstNameController.text,
            "lastName": _lastNameController.text,
            "latitude": "",
            "longitude": "",
            "phone": _phoneController.text,
            "postalCode": _zipCodeController.text,
            "stateProvince": selectedState!.name,
            "zone": selectedState!.code,
          },
          "groups": [],
          "id": 0,
          "emailAddress": _emailController.text,
          "userName": "",
          "firstName": _firstNameController.text,
          "lastName": _lastNameController.text,
          "gender": "",
          "language": "en",
          "provider": "",
          "rating": 0.0,
          "ratingCount": 0,
          "storeCode": "",
        };
        Provider.of<ProfileProvider>(context, listen: false).saveGuestInfo(data,
            () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CheckoutPaymentScreen(),
            ),
          );
          showCustomSnackBar(getTranslated('SAVE_ADDRESS', context)!, context,
              isError: false);
        });
      }
    }
  }

  @override
  void initState() {
    initGuestUser();
    getCountries(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText1!.color, size: 20),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(getTranslated('selectAddress', context)!,
              style: robotoRegular.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1!.color)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme
            ? Colors.black
            : Colors.white.withOpacity(0.5),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                            // SizedBox(height: 10),
                            CustomTextField(
                              labeltext: "First Name",
                              controller: _firstNameController,
                              textInputType: TextInputType.name,
                              focusNode: _firstNameFocus,
                              nextNode: _lastNameFocus,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            CustomTextField(
                              labeltext: "Last Name",
                              controller: _lastNameController,
                              textInputType: TextInputType.name,
                              focusNode: _lastNameFocus,
                              nextNode: _phoneFocus,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            CustomTextField(
                              labeltext: "Phone",
                              controller: _phoneController,
                              textInputType: TextInputType.number,
                              focusNode: _phoneFocus,
                              nextNode: _buttonAddressFocus,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            CustomTextField(
                              labeltext: "Address",
                              controller: _addressController,
                              textInputType: TextInputType.streetAddress,
                              focusNode: _buttonAddressFocus,
                              nextNode: _cityFocus,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            Container(
                              // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 13, 15, 13),
                                ),
                                onChanged: (dynamic value) {
                                  selectedCountry = value;
                                  getState(context, selectedCountry!.code);
                                },
                                value: selectedCountry,
                                hint: Text("Country"),
                                validator: (dynamic value) {
                                  if (value == null) {
                                    return "Please select Country";
                                  }
                                  return null;
                                },
                                items: [
                                  ...Provider.of<MasterProvider>(context,
                                          listen: false)
                                      .countries
                                      .map((countryItem) {
                                    return DropdownMenuItem(
                                      child: Text(countryItem.name!),
                                      value: countryItem,
                                    );
                                  }).toList()
                                ],
                                onSaved: (dynamic value) {
                                  selectedCountry = value;
                                },
                              ),
                            ),
                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            //state
                            Container(
                              // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 13, 15, 13),
                                ),
                                onChanged: (dynamic value) {
                                  selectedState = value;
                                },
                                value: selectedState,
                                hint: Text("State"),
                                validator: (dynamic value) {
                                  if (value == null) {
                                    return "Please select State";
                                  }
                                  return null;
                                },
                                items: [
                                  ...allState.map((stateItem) {
                                    return DropdownMenuItem(
                                      child: Text(stateItem.name ?? ""),
                                      value: stateItem,
                                    );
                                  }).toList()
                                ],
                                onSaved: (dynamic value) {
                                  selectedState = value;
                                },
                              ),
                            ),

                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            CustomTextField(
                              labeltext: "City",
                              controller: _cityNameController,
                              textInputType: TextInputType.streetAddress,
                              focusNode: _cityFocus,
                              nextNode: _zipCodeFocus,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 15),
                            CustomTextField(
                              isPhoneNumber: true,
                              labeltext: "Pincode",
                              controller: _zipCodeController,
                              textInputType: TextInputType.number,
                              nextNode: _emailAddressFocus,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                            CustomTextField(
                              // isPhoneNumber: true,
                              labeltext: "Email",
                              controller: _emailController,
                              textInputType: TextInputType.emailAddress,
                              focusNode: _emailAddressFocus,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(height: 10),
                            Provider.of<ProfileProvider>(context)
                                        .addAddressErrorText !=
                                    null
                                ? Text(
                                    Provider.of<ProfileProvider>(context)
                                        .addAddressErrorText!,
                                    style: titilliumRegular.copyWith(
                                        color: ColorResources.RED))
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      buttonText: "Save",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _updateUserAddress();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
