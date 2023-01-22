import 'package:flutter/material.dart';

class BottomPopupModal extends StatefulWidget {
  const BottomPopupModal({Key? key}) : super(key: key);

  @override
  _BottomPopupModalState createState() => _BottomPopupModalState();
}

class _BottomPopupModalState extends State<BottomPopupModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('modal'),
      ),
    );
  }
}
