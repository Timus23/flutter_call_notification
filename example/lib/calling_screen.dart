import 'package:flutter/material.dart';

class CallingScreen extends StatelessWidget {
  const CallingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("End"),
            ),
          ],
        ),
      ),
    );
  }
}
