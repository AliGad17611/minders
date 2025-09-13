import 'package:flutter/material.dart';

class TopSpace extends StatelessWidget {
  const TopSpace({
    super.key,
    this.height = 111,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
    );
  }
}
