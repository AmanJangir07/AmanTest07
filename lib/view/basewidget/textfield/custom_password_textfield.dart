import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopiana/utill/custom_themes.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintTxt;
  final String? labelText;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;

  CustomPasswordTextField(
      {this.controller,
      this.labelText,
      this.hintTxt,
      this.focusNode,
      this.nextNode,
      this.textInputAction});

  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        // color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3, /* offset: Offset(0, 1) */
          ) // changes position of shadow
        ],
        /* boxShadow: [
          // BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     spreadRadius: 1,
          //     blurRadius: 7,
          //     offset: Offset(0, 1)) // changes position of shadow
        ], */
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColor,
        controller: widget.controller,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        maxLength: 4,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          setState(() {
            widget.textInputAction == TextInputAction.done
                ? FocusScope.of(context).consumeKeyboardToken()
                : FocusScope.of(context).requestFocus(widget.nextNode);
          });
        },
        validator: (value) {
          return value!.length < 4 ? 'pin should be 4 digit' : null;
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          hintStyle:
              titilliumRegular.copyWith(color: Theme.of(context).primaryColor),
          errorStyle: TextStyle(height: 1.5),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          border: InputBorder.none,
          suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _toggle),
          hintText: widget.hintTxt ?? '',
          labelText: widget.labelText,
          // filled: true,
          // fillColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
