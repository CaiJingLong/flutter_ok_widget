import 'package:flutter/material.dart';
import 'package:flutter_ok_widget/flutter_ok_widget.dart';

class TapWrapperExample extends StatefulWidget {
  const TapWrapperExample({Key? key}) : super(key: key);

  @override
  State<TapWrapperExample> createState() => _TapWrapperExampleState();
}

class _TapWrapperExampleState extends State<TapWrapperExample> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap Wrapper Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Tap the button to see the tap wrapper'),
            Text('counter: $_count'),
            TapWrapper(
              padding: const EdgeInsets.all(16),
              onTap: () {
                setState(() {
                  _count++;
                });
              },
              child: const Text('Tap me to add 1 to the counter'),
            ),
          ],
        ),
      ),
    );
  }
}
