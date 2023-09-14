import 'package:flutter/material.dart';
import 'package:shopiana/data/model/response/product_model.dart';

class ProductOptionsWidget extends StatefulWidget {
  final List<ProductOption>? options;
  Map<String?, OptionValue>? selectedOptions;
  final Function? changeProductOptions;
  ProductOptionsWidget(
      {this.options, this.selectedOptions, this.changeProductOptions});

  @override
  State<ProductOptionsWidget> createState() => _ProductOptionsWidgetState();
}

class _ProductOptionsWidgetState extends State<ProductOptionsWidget> {
  void selectProductOption(String? optionName, OptionValue optionValue) {
    setState(() {
      widget.selectedOptions!.update(optionName, (value) => optionValue);
      widget.changeProductOptions!(widget.selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...widget.options!
              .map(
                (option) => Row(
                  children: [
                    Text(option.name!),
                    Text(": "),
                    ...option.optionValues!
                        .map((optionValue) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => selectProductOption(
                                    option.code, optionValue),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 2,
                                        color: optionValue ==
                                                widget.selectedOptions![
                                                    option.name]
                                            ? Colors.green
                                            : Theme.of(context).primaryColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(optionValue.code ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ))
                        .toList()
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
