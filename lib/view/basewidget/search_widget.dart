import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopiana/provider/search_provider.dart';
import 'package:shopiana/provider/theme_provider.dart';
import 'package:shopiana/utill/color_resources.dart';
import 'package:shopiana/utill/dimensions.dart';
import 'package:shopiana/utill/images.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  final String? hintText;
  final Function? onTextChanged;
  final Function onClearPressed;
  final Function? onSubmit;
  SearchWidget(
      {required this.hintText,
      this.onTextChanged,
      required this.onClearPressed,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(
        text: Provider.of<SearchProvider>(context).searchText);
    return Stack(children: [
      /* ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset(
          Images.toolbar_background,
          fit: BoxFit.fill,
          height: 50 + MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? Colors.black
              : null,
        ),
      ), */
      Container(
        height: 100,
        color: Theme.of(context).primaryColor,
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                  color: ColorResources.getTextBg(context),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    Provider.of<SearchProvider>(context, listen: false)
                        .getautoCompleteData(textEditingValue.text);

                    return Provider.of<SearchProvider>(context, listen: false)
                        .autoCompleteResult;
                    /*  .where((String option) {
                      return option.contains(textEditingValue.text.toLowerCase());
                    }); */
                  },
                  onSelected: (String selection) {
                    Provider.of<SearchProvider>(context, listen: false)
                        .saveSearchAddress(selection);
                    Provider.of<SearchProvider>(context, listen: false)
                        .searchProduct(selection);
                    //onSubmit(selection);
                  },
                ),
              ),
              // TextFormField(
              //   controller: _controller,
              //   onFieldSubmitted: (query) {
              //     onSubmit(query);
              //   },
              //   onChanged: (query) {
              //     onTextChanged(query);
              //   },
              //   textInputAction: TextInputAction.search,
              //   maxLines: 1,
              //   textAlignVertical: TextAlignVertical.center,
              //   decoration: InputDecoration(
              //     hintText: hintText,
              //     isDense: true,
              //     hintStyle: robotoRegular.copyWith(
              //         color: Theme.of(context).hintColor),
              //     border: InputBorder.none,
              //     prefixIcon: Icon(Icons.search,
              //         color: ColorResources.getColombiaBlue(context),
              //         size: Dimensions.ICON_SIZE_DEFAULT),
              //     suffixIcon:
              //         Provider.of<SearchProvider>(context).searchText.isNotEmpty
              //             ? IconButton(
              //                 icon: Icon(Icons.clear,
              //                     color: ColorResources.getGrey(context)),
              //                 onPressed: () {
              //                   onClearPressed();
              //                   _controller.clear();
              //                 },
              //               )
              //             : _controller.text.isNotEmpty
              //                 ? IconButton(
              //                     icon: Icon(Icons.clear,
              //                         color: ColorResources.getGrey(context)),
              //                     onPressed: () {
              //                       onClearPressed();
              //                       _controller.clear();
              //                     },
              //                   )
              //                 : null,
              //   ),
              // ),
            ),
          ),
          SizedBox(width: 10),
        ]),
      ),
    ]);
  }
}
