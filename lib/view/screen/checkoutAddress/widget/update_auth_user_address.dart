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

class UpdateAuthUserAddress extends StatefulWidget {
  // final Function callback;
  UserProfile? userProfile;
  UpdateAuthUserAddress({required this.userProfile});
  @override
  State<UpdateAuthUserAddress> createState() => _UpdateAuthUserAddressState();
}

class _UpdateAuthUserAddressState extends State<UpdateAuthUserAddress> {
  final FocusNode _buttonAddressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _gstNumberFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _customerGstNumberController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  CountryMasterModel? selectedCountry;
  StateMasterModel? selectedState;
  List<StateMasterModel> allState = [];

  Future<void> getCountries(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    /* userProfile =
        Provider.of<ProfileProvider>(context, listen: false).userInfoModel; */
    await Provider.of<MasterProvider>(context, listen: false).fetchCountries();
    List<CountryMasterModel> countries =
        Provider.of<MasterProvider>(context, listen: false).countries;
    countries.forEach((country) {
      if (country.name == widget.userProfile!.billing!.country) {
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
      if (state.name == widget.userProfile!.billing!.zone) {
        selectedState = state;
      }
    });

    print("selectedState" + selectedState.toString());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getCountries(context);

    super.initState();
    print("init");
    Provider.of<ProfileProvider>(context, listen: false)
        .setAddAddressErrorText(null);
  }

  _updateUserAddress() async {
    setState(() {
      _isLoading = true;
    });
    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      showCustomSnackBar("Phone Number is Required", context, isError: true);
      setState(() {
        _isLoading = false;
      });
    } else if (_addressController.text.isEmpty) {
      showCustomSnackBar("Address is Required", context, isError: true);
      setState(() {
        _isLoading = false;
      });
    } else if (_firstNameController.text.isEmpty) {
      showCustomSnackBar("First name is Required", context, isError: true);
      setState(() {
        _isLoading = false;
      });
    } else if (_lastNameController.text.isEmpty) {
      showCustomSnackBar("Last name is Required", context, isError: true);
      setState(() {
        _isLoading = false;
      });
    } else if (_zipCodeController.text.isEmpty) {
      showCustomSnackBar("Zip code is Required", context, isError: true);
      setState(() {
        _isLoading = false;
      });
    } else {
      ProfileProvider profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      UserProfile userInfoModel = profileProvider.userInfoModel!;

      if (userInfoModel.billing?.firstName == _firstNameController.text &&
          userInfoModel.billing?.lastName == _lastNameController.text &&
          userInfoModel.billing?.phone == _phoneController.text &&
          userInfoModel.billing?.city == _cityNameController.text &&
          userInfoModel.billing?.address == _addressController.text &&
          userInfoModel.billing?.postalCode == _zipCodeController.text &&
          userInfoModel.billing?.stateProvince == selectedState!.name &&
          userInfoModel.billing?.countryCode == selectedCountry!.code &&
          userInfoModel.billing?.zone == selectedState!.code &&
          userInfoModel.billing?.country == selectedCountry!.code) {
        print('object');
        // showCustomSnackBar(
        //     getTranslated('change_something_for_update', context), context,
        //     isError: true);
      } else {
        userInfoModel.billing?.firstName = _firstNameController.text;
        userInfoModel.billing?.lastName = _lastNameController.text;
        userInfoModel.billing?.phone = _phoneController.text;
        userInfoModel.billing?.city = _cityNameController.text;
        userInfoModel.billing?.address = _addressController.text;
        userInfoModel.billing?.postalCode = _zipCodeController.text;
        userInfoModel.billing?.stateProvince = selectedState!.name ?? "";
        userInfoModel.billing?.countryCode = selectedCountry!.code ?? "";
        userInfoModel.billing?.zone = selectedState!.code ?? "";
        userInfoModel.billing?.country = selectedCountry!.code ?? "";

        // shipping address update
        userInfoModel.delivery?.firstName = _firstNameController.text;
        userInfoModel.delivery?.lastName = _lastNameController.text;
        userInfoModel.delivery?.phone = _phoneController.text;
        userInfoModel.delivery?.city = _cityNameController.text;
        userInfoModel.delivery?.address = _addressController.text;
        userInfoModel.delivery?.postalCode = _zipCodeController.text;
        userInfoModel.delivery?.stateProvince = selectedState!.code ?? "";
        userInfoModel.delivery?.countryCode = selectedCountry!.code ?? "";
        userInfoModel.delivery?.zone = selectedState!.code ?? "";
        userInfoModel.delivery?.country = selectedCountry!.code ?? "";
        userInfoModel.customerGstNumber = _customerGstNumberController.text;
        await profileProvider.updateUserInfo(userInfoModel);
        await profileProvider.getUserInfo();

        if (profileProvider.userInfoModel != null) {
          showCustomSnackBar(
              getTranslated('update_successfully', context)!, context,
              isError: false);
          Navigator.pop(context);
        } else {
          showCustomSnackBar(
              getTranslated('something_went_wrong', context)!, context);
        }
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn =
    //     Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.bodyText1!.color, size: 20),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Text(getTranslated('UPDATE_ADDRESS', context)!,
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
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          if (profile.isAvailableProfile && (profile.userInfoModel != null)) {
            _firstNameController.text =
                profile.userInfoModel?.billing?.firstName ?? "";
            _lastNameController.text =
                profile.userInfoModel?.billing?.lastName ?? "";
            _phoneController.text = profile.userInfoModel?.billing?.phone ?? "";
            _addressController.text =
                profile.userInfoModel?.billing?.address ?? "";
            _cityNameController.text =
                profile.userInfoModel?.billing?.city ?? "";
            _zipCodeController.text =
                profile.userInfoModel?.billing?.postalCode ?? "";
            _customerGstNumberController.text =
                profile.userInfoModel?.customerGstNumber ?? "";
          }

          return Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          /* const TextFieldlable("Enter_firstName"),
                                SizedBox(height: Dimensions.MARGIN_SIZE_SMALL), */
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          Container(
                            // padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10)),
                            child: _isLoading
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                : DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15, 13, 15, 13),
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
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          //state
                          Container(
                            // padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10)),
                            child: _isLoading
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                : DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15, 13, 15, 13),
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
                          /*  const TextFieldlable("ENTER_YOUR_CITY"), */
                          SizedBox(
                            height: Dimensions.MARGIN_SIZE_SMALL,
                          ),
                          CustomTextField(
                            labeltext: "First Name*",
                            controller: _firstNameController,
                            textInputType: TextInputType.name,
                            focusNode: _firstNameFocus,
                            nextNode: _lastNameFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          /* Divider(
                                    thickness: 0.7, color: ColorResources.GREY),
                                const TextFieldlable("Enter_lastName"), */
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          CustomTextField(
                            labeltext: "Last Name*",
                            controller: _lastNameController,
                            textInputType: TextInputType.name,
                            focusNode: _lastNameFocus,
                            nextNode: _phoneFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          /* Divider(
                                    thickness: 0.7, color: ColorResources.GREY),
                                const TextFieldlable("Phone"), */
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          CustomTextField(
                            labeltext: "Phone*",
                            controller: _phoneController,
                            isPhoneNumber: true,
                            textInputType: TextInputType.phone,
                            focusNode: _phoneFocus,
                            nextNode: _buttonAddressFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          /* Divider(
                                    thickness: 0.7, color: ColorResources.GREY),
                                const TextFieldlable("ENTER_YOUR_ADDRESS"), */
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          CustomTextField(
                            labeltext: "Address*",
                            controller: _addressController,
                            textInputType: TextInputType.streetAddress,
                            focusNode: _buttonAddressFocus,
                            nextNode: _cityFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          /* Divider(
                                    thickness: 0.7, color: ColorResources.GREY), */
                          CustomTextField(
                            labeltext: "City",
                            controller: _cityNameController,
                            textInputType: TextInputType.streetAddress,
                            focusNode: _cityFocus,
                            nextNode: _gstNumberFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          CustomTextField(
                            labeltext: "Gst Number",
                            controller: _customerGstNumberController,
                            textInputType: TextInputType.text,
                            focusNode: _gstNumberFocus,
                            nextNode: _zipCodeFocus,
                            textInputAction: TextInputAction.next,
                          ),
                          /* Divider(
                                    thickness: 0.7, color: ColorResources.GREY),
                                const TextFieldlable("ENTER_YOUR_ZIP_CODE"), */
                          SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                          CustomTextField(
                            labeltext: "Zip Code*",
                            isPhoneNumber: true,
                            controller: _zipCodeController,
                            textInputType: TextInputType.number,
                            focusNode: _zipCodeFocus,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 30),
                          profileProvider.addAddressErrorText != null
                              ? Text(profileProvider.addAddressErrorText!,
                                  style: titilliumRegular.copyWith(
                                      color: ColorResources.RED))
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  buttonText: profile.isAvailableProfile
                      ? getTranslated('UPDATE_ADDRESS', context)
                      : getTranslated('add_new_address', context),
                  onTap: () {
                    print('test');
                    if (_formKey.currentState!.validate() &&
                        profile.isAvailableProfile) {
                      _updateUserAddress();
                    }
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TextFieldlable extends StatelessWidget {
  final String labelName;
  const TextFieldlable(this.labelName);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(getTranslated(labelName, context)!, style: titilliumRegular)
      ],
    );
  }
}
