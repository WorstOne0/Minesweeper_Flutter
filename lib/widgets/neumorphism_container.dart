import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class NeumorphismContainer extends StatefulWidget {
  const NeumorphismContainer({required this.isPressed, required this.child, super.key});

  final bool isPressed;
  final Widget child;

  @override
  State<NeumorphismContainer> createState() => _NeumorphismContainerState();
}

class _NeumorphismContainerState extends State<NeumorphismContainer> {
  @override
  Widget build(BuildContext context) {
    double depth = widget.isPressed ? -5 : 5;
    double intensity = widget.isPressed ? 10 : 1;

    return Neumorphic(
      duration: const Duration(milliseconds: 100),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        depth: depth,
        intensity: intensity,
        surfaceIntensity: 0.5,
      ),
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: widget.child,
      ),
    );

    // Offset offset = widget.isPressed ? const Offset(5, 5) : const Offset(8, 8);
    // double blur = widget.isPressed ? 5 : 30;
    // return AnimatedContainer(
    //   duration: const Duration(milliseconds: 100),
    //   height: 100,
    //   width: 100,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(15),
    //     color: Colors.blue,
    //     boxShadow: [
    //       BoxShadow(
    //         offset: -offset,
    //         color: Colors.white,
    //         blurRadius: blur,
    //         // inset: widget.isPressed,
    //       ),
    //       BoxShadow(
    //         offset: offset,
    //         color: const Color(0xffd2d1d1),
    //         blurRadius: blur,
    //         // inset: widget.isPressed,
    //       ),
    //     ],
    //   ),
    // );
  }
}
