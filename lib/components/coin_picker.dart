import 'package:flutter/material.dart';


class CoinPicker extends StatelessWidget{

  final Widget? child;

  const CoinPicker(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 30.0),
      color: Colors.lightBlue,
      child: child,
    );
  }

}