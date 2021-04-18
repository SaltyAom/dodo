import 'package:flutter/material.dart';

import 'package:niku/niku.dart';

class RetryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RetryButton({
    Key? key,
    this.text = 'Retry',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NikuButton.outlined(
      Text(text),
    )
      ..onPressed(onPressed)
      ..fontSize(14)
      ..w500()
      ..py(16)
      ..px(48)
      ..mt(28);
  }
}
