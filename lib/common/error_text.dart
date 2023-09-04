import 'package:flutter/material.dart';

class Errortext extends StatelessWidget {
  final String text;
  const Errortext({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
