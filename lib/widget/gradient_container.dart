import 'package:flutter/cupertino.dart';

import '../utils/custom_color.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.5, -0.5),
          radius: 0.8,
          colors: [gradient1, gradient2],
        ),
      ),
      child: child,
    );
  }
}
