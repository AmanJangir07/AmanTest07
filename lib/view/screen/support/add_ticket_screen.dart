import 'package:flutter/material.dart';
import 'package:shopiana/data/model/body/support_ticket_body.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/localization/language_constrants.dart';
import 'package:shopiana/provider/support_ticket_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/custom_themes.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/view/basewidget/button/custom_button.dart';
import 'package:shopiana/view/basewidget/show_custom_snakbar.dart';
import 'package:shopiana/view/basewidget/custom_expanded_app_bar.dart';
import 'package:shopiana/view/basewidget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddTicketScreen extends StatefulWidget {
  final String type;
  AddTicketScreen({required this.type});

  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _subjectNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      isGuestCheck: true,
      child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          children: [
            Text(getTranslated('add_new_ticket', context)!,
                style: titilliumSemiBold.copyWith(fontSize: 20)),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            Container(
              color: ColorResources.getLowGreen(context),
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
              child: ListTile(
                leading: Icon(Icons.query_builder,
                    color: ColorResources.getPrimary(context)),
                title: Text(widget.type, style: robotoBold),
                onTap: () {},
              ),
            ),
            CustomTextField(
              focusNode: _subjectNode,
              nextNode: _descriptionNode,
              textInputAction: TextInputAction.next,
              hintText: getTranslated('write_your_subject', context),
              controller: _subjectController,
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            CustomTextField(
              focusNode: _descriptionNode,
              textInputAction: TextInputAction.newline,
              hintText: getTranslated('issue_description', context),
              textInputType: TextInputType.multiline,
              controller: _descriptionController,
              maxLine: 5,
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            Provider.of<SupportTicketProvider>(context).isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor)))
                : Builder(
                    key: _scaffoldKey,
                    builder: (context) => CustomButton(
                        buttonText: getTranslated('submit', context),
                        onTap: () {
                          if (_subjectController.text.isEmpty) {
                            showCustomSnackBar(
                                'Subject box should not be empty', context);
                          } else if (_descriptionController.text.isEmpty) {
                            showCustomSnackBar(
                                'Description box should not be empty', context);
                          } else {
                            SupportTicketBody supportTicketModel =
                                SupportTicketBody(
                                    widget.type,
                                    _subjectController.text,
                                    _descriptionController.text);
                            Provider.of<SupportTicketProvider>(context,
                                    listen: false)
                                .sendSupportTicket(
                                    supportTicketModel, callback);
                          }
                        }),
                  ),
          ]),
    );
  }

  void callback(bool isSuccess, String message) {
    if (isSuccess) {
      _subjectController.text = '';
      _descriptionController.text = '';
      Navigator.of(context).pop();
    } else {}
  }
}
