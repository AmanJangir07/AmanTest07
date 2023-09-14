import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopiana/provider/product_details_provider.dart';

class QuantityDropDown extends StatefulWidget {
  late Function selectProductQty;
  QuantityDropDown(selectedProductQty) {
    this.selectProductQty = selectedProductQty;
  }
  @override
  _QuantityDropDownState createState() => _QuantityDropDownState();
}

class _QuantityDropDownState extends State<QuantityDropDown> {
  TextEditingController quantityController = new TextEditingController();
  int? _chosenValue = 1;
  List<int> quantityValueList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
  ];

  dynamic _getTenPlusQuantity(value) {
    setState(
      () {
        Provider.of<ProductDetailsProvider>(context, listen: false)
            .setQuantity(int.parse(value));

        _chosenValue = int.parse(value);
      },
    );
    // Navigator.of(context).pop();
    Navigator.of(context).pop();
    quantityController.clear();
  }

  void _buildPopupDialog(context, callbackQunatityFn) {
    showDialog(
      context: context,
      builder: (ctx) {
        return new AlertDialog(
          title: const Text('Enter your quantity'),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: quantityController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            new TextButton(
              onPressed: () {
                if (quantityController.text.isNotEmpty) {
                  callbackQunatityFn(quantityController.text);
                  widget.selectProductQty(_chosenValue);
                  //_getTenPlusQuantity(quantityController.text);
                  Navigator.of(context).pop();
                } else {}
                // Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
            new TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      // alignment: Alignment.center,
      // value: _chosenValue,
      value: null,
      elevation: 5,
      // onChanged: (_) {},
      style: TextStyle(color: Colors.black),
      hint: Text(
        "qty. ${_chosenValue}",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      // alignment: Alignment.center,
      items: [
        ...quantityValueList.map<DropdownMenuItem<int>>(
          (int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
              // alignment: Alignment.center,
            );
          },
        ).toList(),
        DropdownMenuItem<int>(
          child: InkWell(
            onTap: () {
              _buildPopupDialog(context, _getTenPlusQuantity);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 50,
              height: 50,
              child: Text(
                "10+",
              ),
            ),
          ),
          value: _chosenValue,
        ),
      ],

      onChanged: (int? value) {
        widget.selectProductQty(value);
        setState(() {
          _chosenValue = value;
        });
      },
    );
  }
}
