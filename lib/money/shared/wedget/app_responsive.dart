import 'package:flutter/material.dart';

import '../const/app_value.dart';



class ResponsiveView extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveView({
    Key? key,
    required this.child,
    this.maxWidth = AppValues.tabletWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}