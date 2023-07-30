import 'package:flutter/material.dart';

class HoldButton extends StatefulWidget {
  /// Called when pressing is started
  final VoidCallback onStarted;

  /// Called when pressing is stopped
  final VoidCallback onStopped;

  /// Initial delay before on started is called
  final int initialDelay;

  /// True if the button is enabled
  final bool enabled;

  /// The child widget
  final Widget child;

  /// The background color of the button
  final Color backgroundColor;

  const HoldButton(
      {Key? key,
      required this.onStarted,
      required this.onStopped,
      this.initialDelay = 300,
      this.enabled = true,
      required this.child,
      required this.backgroundColor})
      : super(key: key);

  @override
  HoldButtonState createState() => HoldButtonState();
}

class HoldButtonState extends State<HoldButton> {
  /// True if the button is currently being held
  bool _holding = false;

  @override
  Widget build(BuildContext context) {
    const shape = StadiumBorder();
    return Material(
      color: widget.backgroundColor,
      shape: shape,
      child: IgnorePointer(
        ignoring: !widget.enabled,
        child: InkWell(
          onTap: () => _stopHolding(),
          onTapDown: (_) => _startHolding(),
          onTapCancel: () => _stopHolding(),
          customBorder: shape,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Future<void> _startHolding() async {
    // Make sure this isn't called more than once for
    // whatever reason.
    if (_holding) return;
    _holding = true;
    
    await Future.delayed(Duration(milliseconds: widget.initialDelay));
    widget.onStarted();
  }

  void _stopHolding() {
    _holding = false;
    widget.onStopped();
  }
}
