import 'package:flutter/material.dart';

class FadeRoute extends StatefulWidget {
  @override
  _FadeRouteState createState() => _FadeRouteState();
}

class _FadeRouteState extends State<FadeRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfffd16900),
      child: FadeTransition(
        opacity: _animation,
        child: const Padding(
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
