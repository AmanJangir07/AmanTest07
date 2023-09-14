import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  // const LoadingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Column(
          children: [
            Text('Loading Content'),
            SizedBox(height: 10),
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
