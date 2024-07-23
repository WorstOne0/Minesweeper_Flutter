import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The following code implements the legacy ResponsiveWrapper AutoScale functionality
    // using the new ResponsiveScaledBox. The ResponsiveScaledBox widget preserves
    // the legacy ResponsiveWrapper behavior, scaling the UI instead of resizing.
    //
    // **MaxWidthBox** - A widget that limits the maximum width.
    // This is used to create a gutter area on either side of the content.
    //
    // **ResponsiveScaledBox** - A widget that  renders its child
    // with a FittedBox set to the `width` value. Set the fixed width value
    // based on the active breakpoint.

    double width = MediaQuery.of(context).size.width;

    return MaxWidthBox(
      maxWidth: 1280,
      background: Container(color: Theme.of(context).colorScheme.surface),
      child: ResponsiveScaledBox(
        width: ResponsiveValue<double>(
          context,
          defaultValue: 650,
          conditionalValues: [
            Condition.equals(name: MOBILE, value: width),
            // Tablet 1
            Condition.between(start: 501, end: 850, value: 680),
            // Tablet 2
            Condition.between(start: 851, end: 1024, value: 700),
            Condition.between(start: 1025, end: 1200, value: 1000),
            // There are no conditions for width over 1200
            // because the `maxWidth` is set to 1200 via the MaxWidthBox.
          ],
        ).value,
        child: BouncingScrollWrapper.builder(
          context,
          child,
          dragWithMouse: true,
        ),
      ),
    );
  }
}
