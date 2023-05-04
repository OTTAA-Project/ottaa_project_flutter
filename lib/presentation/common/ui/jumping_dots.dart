import 'package:flutter/material.dart';

class JumpingDotsProgressIndicator extends StatefulWidget {
  final int numberOfDots;
  final Color dotColor;

  const JumpingDotsProgressIndicator(
      {Key? key, this.numberOfDots = 3, this.dotColor = Colors.white})
      : super(key: key);

  @override
  JumpingDotsProgressIndicatorState createState() =>
      JumpingDotsProgressIndicatorState();
}

class JumpingDotsProgressIndicatorState
    extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  List<AnimationController> _animationControllers = [];

  final List<Animation<double>> _animations = [];

  int animationDuration = 200;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initAnimation() {
    _animationControllers = List.generate(
      widget.numberOfDots,
      (index) {
        return AnimationController(
            vsync: this, duration: Duration(milliseconds: animationDuration));
      },
    ).toList();

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animations.add(
          Tween<double>(begin: 0, end: -10).animate(_animationControllers[i]));
    }

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animationControllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationControllers[i].reverse();
          if (i != widget.numberOfDots - 1) {
            _animationControllers[i + 1].forward();
          }
        }
        if (i == widget.numberOfDots - 1 &&
            status == AnimationStatus.dismissed) {
          _animationControllers[0].forward();
        }
      });
    }
    _animationControllers.first.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 30,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.numberOfDots, (index) {
            return AnimatedBuilder(
              animation: _animationControllers[index],
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(2.5),
                  child: Transform.translate(
                    offset: Offset(0, _animations[index].value),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: widget.dotColor),
                      height: 10,
                      width: 10,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
