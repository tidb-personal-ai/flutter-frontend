import 'package:flutter/material.dart';

class GlowingOrb extends StatefulWidget {
  const GlowingOrb({super.key, required this.backgroundColor});

  /// The background color of the orb
  final Color backgroundColor;

  @override
  State<GlowingOrb> createState() => _GlowingOrbState();
}

class _GlowingOrbState extends State<GlowingOrb> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync:this, duration: const Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation =  Tween(begin: 2.0,end: 10.0).animate(_animationController)..addListener((){
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: widget.backgroundColor.withOpacity(0.75),
                  blurRadius: _animation.value,
                  spreadRadius: _animation.value,
                ),
              ],
            ),
            child: Container(),
          );
  }
}
