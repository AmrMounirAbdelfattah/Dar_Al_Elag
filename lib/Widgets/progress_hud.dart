import 'gradient_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class ProgressHUD extends StatefulWidget {
  final Widget child;
  final bool inAsyncCall;
  final Color color;

  const ProgressHUD({
    this.child,
    this.inAsyncCall,
    this.color = Colors.black,
  }) : super();

  @override
  _ProgressHUDState createState() => _ProgressHUDState();
}

class _ProgressHUDState extends State<ProgressHUD>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(AnimatedOpacity(
      duration: Duration(milliseconds: 250),
      opacity: widget.inAsyncCall ? 0.5 : 1,
      child: IgnorePointer(
        ignoring: widget.inAsyncCall,
        child: widget.child,
      ),
    ));

    if (widget.inAsyncCall) {
      final modal = Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: GradientCircularProgressIndicator(
              radius: 30,
              gradientColors: [
                Color(0xffc0caf7).withOpacity(0.82),
                Color(0xff051DA4).withOpacity(0.82),
              ],
              strokeWidth: 10.0,
            ),
          ),
        ),
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
