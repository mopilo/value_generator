import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final TextStyle?  style;
  final TextAlign? align;

  const TextWidget(
      {Key? key,
    @required this.text, this.style, this.align

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      style: style,
    );
  }
}
