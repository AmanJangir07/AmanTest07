import 'package:flutter/material.dart';

class SectionDividerWidget extends StatelessWidget {
  const SectionDividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 3,
      height: 5,
    );
  }
}
