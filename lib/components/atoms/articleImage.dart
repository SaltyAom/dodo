import 'package:flutter/material.dart';

import 'package:niku/niku.dart';

class ArticleImage extends StatelessWidget {
  final String url;

  const ArticleImage(
    this.url, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Image.network(
      url,
      fit: BoxFit.cover,
    ).niku()
      ..bg(isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade200)
      ..rounded(4)
      ..my(8);
  }
}
