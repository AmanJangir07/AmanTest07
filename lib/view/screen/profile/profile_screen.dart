import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopiana/data/model/body/country_master_model.dart';
import 'package:shopiana/data/model/body/state_master_model.dart';
import 'package:shopiana/data/model/response/user_profile.dart' as up;
import 'package:shopiana/data/model/response/user_profile.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/master_provider.dart';
import 'package:shopiana/provider/profile_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/button/custom_theme_button.dart';
import 'package:shopiana/view/basewidget/textfield/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _buttonAddressFocus = FocusNode();
  final FocusNode _zoneFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? file;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CountryMasterModel? selectedCountry;
  StateMasterModel? selectedState;
  List<StateMasterModel> allState = [];
  UserProfile? userProfile;
  bool _isLoading = false;

  _updateUserAccount() async {
    /*  if (Provider.of<ProfileProvider>(context, listen: false)
                    .userInfoModel
                    .firstName ==
                _firstNameController.text &&
            Provider.of<ProfileProvider>(context, listen: false)
                    .userInfoModel
                    .lastName ==
                _lastNameController.text
        /*  &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel
                .billing
                .phone ==
            _phoneController.text &&
        file == null &&
        _passwordController.text.isEmpty &&
        _confirmPasswordController.text.isEmpty */
        ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Change something to update'),
          backgroundColor: ColorResources.RED));
    } /* else if ((_passwordController.text.isNotEmpty &&
            _passwordController.text.length < 4) ||
        (_confirmPasswordController.text.isNotEmpty &&
            _confirmPasswordController.text.length < 4)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pin should be 4 digits'),
          backgroundColor: ColorResources.RED));
    } else if (_confirmPasswordController.text.isNotEmpty &&
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pin does not matched'),
          backgroundColor: ColorResources.RED));
    } */
    else { */
    up.UserProfile updateUserInfoModel =
        Provider.of<ProfileProvider>(context, listen: false).userInfoModel!;
    // updateUserInfoModel.method = 'put';
    updateUserInfoModel.firstName = _firstNameController.text;
    updateUserInfoModel.lastName = _lastNameController.text;
    updateUserInfoModel.emailAddress = _emailController.text;
    up.UserBilling billing = up.UserBilling(
        address: _addressController.text,
        postalCode: _zipCodeController.text,
        zone: selectedState!.code,
        country: selectedCountry!.code);
    up.UserDelivery delivery = up.UserDelivery(
        address: _addressController.text,
        postalCode: _zipCodeController.text,
        zone: selectedState!.code,
        country: selectedCountry!.code);

    updateUserInfoModel.billing = billing;
    updateUserInfoModel.delivery = delivery;
    // updateUserInfoModel.phone = _phoneController.text ?? '';
    await Provider.of<ProfileProvider>(context, listen: false)
        .updateUserInfo(updateUserInfoModel);
    // Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Updated Successfully'),
        backgroundColor: ColorResources.GREEN));
    _addressController.clear();
    _countryController.clear();
    _emailController.clear();
    _zipCodeController.clear();
    _zoneController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    setState(() {});
    //}
  }

  @override
  void initState() {
    getCountries(context);
    Provider.of<ProfileProvider>(context, listen: false)
        .setAddAddressErrorText(null);
    super.initState();
    // Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList();
    // Provider.of<ProfileProvider>(context, listen: false).initAddressList();
    NetworkInfo.checkConnectivity(context);
  }

  Future<void> getCountries(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    userProfile = await Provider.of<ProfileProvider>(context, listen: false)
        .userInfoModel;
    await Provider.of<MasterProvider>(context, listen: false).fetchCountries();
    List<CountryMasterModel> countries =
        await Provider.of<MasterProvider>(context, listen: false).countries;
    countries.forEach((country) {
      if (country.code == userProfile!.billing!.country) {
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
      if (state.code == userProfile!.billing!.zone) {
        selectedState = state;
      }
    });

    print("selectedState" + selectedState.toString());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          _firstNameController.text = profile.userInfoModel?.firstName ?? "";
          _lastNameController.text = profile.userInfoModel?.lastName ?? "";
          _emailController.text = profile.userInfoModel?.emailAddress ?? "";
          _phoneController.text = profile.userInfoModel!.userName ?? "";
          // _countryController.text = profile?.userInfoModel?.billing?.country;
          _addressController.text =
              profile.userInfoModel!.billing!.address ?? "";
          _zipCodeController.text =
              profile.userInfoModel!.billing!.postalCode ?? "";
          // _zoneController.text = profile?.userInfoModel?.billing?.zone;
          return /* Stack(
            clipBehavior: Clip.none,
            children: [ */
              /* Container(height: 500, color: Theme.of(context).primaryColor),
              Container(
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Row(children: [
                  CupertinoNavigationBarBackButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(getTranslated('PROFILE', context)!,
                      style: titilliumRegular.copyWith(
                          fontSize: 20, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ]),
              ), */
              Container(
            child: Column(
              children: [
                Column(
                  children: [
                    /* Text(
                          '${profile.userInfoModel.firstName} ${profile.userInfoModel.lastName}',
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.WHITE, fontSize: 20.0),
                        ) */
                  ],
                ),
                SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorResources.getIconBg(context),
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(Dimensions.MARGIN_SIZE_DEFAULT),
                          topRight:
                              Radius.circular(Dimensions.MARGIN_SIZE_DEFAULT),
                        )),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  /*  Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text(
                                              getTranslated(
                                                  'FIRST_NAME', context),
                                              style: titilliumRegular)
                                        ],
                                      ), */
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.name,
                                    focusNode: _fNameFocus,
                                    nextNode: _lNameFocus,
                                    labeltext: "First Name",
                                    hintText:
                                        profile.userInfoModel!.firstName ?? '',
                                    controller: _firstNameController,
                                  ),
                                ],
                              )),
                              SizedBox(width: 15),
                              Expanded(
                                  child: Column(
                                children: [
                                  /* Row(
                                        children: [
                                          Icon(Icons.person,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 20),
                                          SizedBox(
                                              width: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Text(
                                              getTranslated(
                                                  'LAST_NAME', context),
                                              style: titilliumRegular)
                                        ],
                                      ), */
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.name,
                                    focusNode: _lNameFocus,
                                    nextNode: _emailFocus,
                                    labeltext: "Last Name",
                                    hintText: profile.userInfoModel!.lastName,
                                    controller: _lastNameController,
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_SMALL,
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                          child: CustomTextField(
                            textInputType: TextInputType.number,
                            focusNode: _phoneFocus,
                            isPhoneNumber: true,
                            labeltext: "Mobile number",
                            readOnly: true,
                            hintText: profile.userInfoModel!.userName ?? '',
                            controller: _phoneController,
                          ),
                        ),
                        // !for Email
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_SMALL,
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                          child: Column(
                            children: [
                              /*  Row(
                                    children: [
                                      Icon(Icons.phone_iphone,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      SizedBox(
                                        width:
                                            Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                                      ),
                                      Text(getTranslated('PHONE_NO', context),
                                          style: titilliumRegular)
                                    ],
                                  ), */
                              SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                              Container(
                                // padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButtonFormField(
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
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                Dimensions.MARGIN_SIZE_SMALL),
                                        CustomTextField(
                                          labeltext: "Pincode",
                                          isPhoneNumber: true,
                                          controller: _zipCodeController,
                                          textInputType: TextInputType.number,
                                          focusNode: _zipCodeFocus,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ],
                                    )),
                                    SizedBox(width: 15),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                Dimensions.MARGIN_SIZE_SMALL),
                                        Container(
                                          // padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 13, 0, 13),
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
                                                  child: Text(stateItem.name!),
                                                  value: stateItem,
                                                );
                                              }).toList()
                                            ],
                                            onSaved: (dynamic value) {
                                              selectedState = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                              CustomTextField(
                                labeltext: "Address",
                                controller: _addressController,
                                textInputType: TextInputType.streetAddress,
                                focusNode: _addressFocus,
                                nextNode: _zoneFocus,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                              CustomTextField(
                                textInputType: TextInputType.number,
                                focusNode: _emailFocus,
                                labeltext: "Email",
                                nextNode: _passwordFocus,
                                hintText:
                                    profile.userInfoModel!.emailAddress ?? '',
                                controller: _emailController,
                              ),
                            ],
                          ),
                        ),

                        // // for Phone No
                        // Container(
                        //   margin: EdgeInsets.only(
                        //       top: Dimensions.MARGIN_SIZE_SMALL,
                        //       left: Dimensions.MARGIN_SIZE_DEFAULT,
                        //       right: Dimensions.MARGIN_SIZE_DEFAULT),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Icon(Icons.dialpad,
                        //               color: ColorResources.getLightSkyBlue(
                        //                   context),
                        //               size: 20),
                        //           SizedBox(
                        //               width: Dimensions
                        //                   .MARGIN_SIZE_EXTRA_SMALL),
                        //           Text(getTranslated('PHONE_NO', context),
                        //               style: titilliumRegular)
                        //         ],
                        //       ),
                        //       SizedBox(
                        //           height: Dimensions.MARGIN_SIZE_SMALL),
                        //       CustomTextField(
                        //         textInputType: TextInputType.number,
                        //         focusNode: _phoneFocus,
                        //         // hintText: profile.userInfoModel.phone ?? "",
                        //         nextNode: _addressFocus,
                        //         controller: _phoneController,
                        //         isPhoneNumber: true,
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // for Address
                        /*  Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_SMALL,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Consumer<ProfileProvider>(
                                    builder:
                                        (context, profileProvider, child) =>
                                            Row(
                                      children: [
                                        IconButton(
                                            padding: EdgeInsets.all(0),
                                            icon: Icon(Icons.home,
                                                color:
                                                    profileProvider
                                                            .isHomeAddress
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : ColorResources
                                                            .getColombiaBlue(
                                                                context),
                                                size: 35),
                                            onPressed: () {
                                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddAddressScreen(userInfoModel)));
                                              //profileProvider.updateAddressCondition(true);
                                              profileProvider
                                                  .updateAddressCondition(true);
                                            }),
                                        SizedBox(
                                            width:
                                                Dimensions.MARGIN_SIZE_LARGE),
                                        GestureDetector(
                                          onTap: () {
                                            profileProvider
                                                .updateAddressCondition(false);
                                          },
                                          child: Image.asset(
                                            Images.bag,
                                            width: 30,
                                            height: 30,
                                            color: !profileProvider
                                                    .isHomeAddress
                                                ? Theme.of(context).primaryColor
                                                : ColorResources
                                                    .getColombiaBlue(context),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                Dimensions.MARGIN_SIZE_LARGE),
                                        /* Container(
                                          width: 25,
                                          height: 25,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: ColorResources.WHITE,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              )
                                            ],
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) =>
                                                   
                                              );
                                            },
                                            icon: Icon(Icons.add,
                                                color: ColorResources
                                                    .getColombiaBlue(context),
                                                size: 20),
                                          ),
                                        ), */
                                        SizedBox(
                                            width:
                                                Dimensions.MARGIN_SIZE_LARGE),
                                        Container(
                                          width: 25,
                                          height: 25,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: ColorResources.WHITE,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              )
                                            ],
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddressListScreen(profile
                                                              .userInfoModel)));
                                            },
                                            icon: Icon(Icons.done_all,
                                                color: ColorResources
                                                    .getColombiaBlue(context),
                                                size: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  Consumer<ProfileProvider>(
                                    builder:
                                        (context, profileProvider, child) =>
                                            Container(
                                      width: double.infinity,
                                      height: 45,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          )
                                        ],
                                      ),
                                      child: Text(
                                          profileProvider.isHomeAddress
                                              ? profileProvider.getHomeAddress()
                                              : profileProvider
                                                      .getOfficeAddress() ??
                                                  getTranslated(
                                                      'ADDRESS_NOT_FOUND',
                                                      context),
                                          textAlign: TextAlign.left),
                                    ),
                                  ),
                                ],
                              ),
                            ), */

                        // for Password
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.MARGIN_SIZE_SMALL,
                              left: Dimensions.MARGIN_SIZE_DEFAULT,
                              right: Dimensions.MARGIN_SIZE_DEFAULT),
                          child: Column(
                            children: [
                              /*  Row(
                                    children: [
                                      Icon(Icons.lock_open,
                                          color: ColorResources.getPrimary(
                                              context),
                                          size: 20),
                                      SizedBox(
                                          width: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Text(getTranslated('PASSWORD', context),
                                          style: titilliumRegular)
                                    ],
                                  ), */
                              /* SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    focusNode: _passwordFocus,
                                    labeltext: "Pin",
                                    nextNode: _confirmPasswordFocus,
                                    controller: _passwordController,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  // CustomPasswordTextField(
                                  //   controller: _passwordController,
                                  //   focusNode: _passwordFocus,
                                  //   nextNode: _confirmPasswordFocus,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                ],
                              ),
                            ),

                            // for  re-enter Password
                            Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_SMALL,
                                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                                  right: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  /*  Row(
                                    children: [
                                      Icon(Icons.lock_open,
                                          color: ColorResources.getPrimary(
                                              context),
                                          size: 20),
                                      SizedBox(
                                          width: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Text(
                                          getTranslated(
                                              'RE_ENTER_PASSWORD', context),
                                          style: titilliumRegular)
                                    ],
                                  ), */
                                  SizedBox(
                                      height: Dimensions.MARGIN_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    focusNode: _confirmPasswordFocus,
                                    controller: _confirmPasswordController,
                                    labeltext: "Re-enter pin",
                                    textInputAction: TextInputAction.done,
                                  ), */
                              // CustomPasswordTextField(
                              //   controller: _confirmPasswordController,
                              //   focusNode: _confirmPasswordFocus,
                              //   textInputAction: TextInputAction.done,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.MARGIN_SIZE_LARGE,
                      vertical: Dimensions.MARGIN_SIZE_SMALL),
                  child: !Provider.of<ProfileProvider>(context).isLoading
                      ? CustomThemeButton(
                          onTap: _updateUserAccount,
                          buttonText: getTranslated('UPDATE_ACCOUNT', context))
                      : Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor))),
                ),
              ],
            ),
          );
          /* ],
          ); */
        },
      ),
    );
  }
}
