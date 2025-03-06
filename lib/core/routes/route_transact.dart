import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 1000), // Slow down animation (1 second)
    reverseTransitionDuration: Duration(milliseconds: 1000), // Slow down reverse animation
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide from right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      // Forward animation (push)
      var pushAnimation =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var pushOffsetAnimation = animation.drive(pushAnimation);

      // Reverse animation (pop)
      var popAnimation = Tween(begin: Offset.zero, end: begin)
          .chain(CurveTween(curve: curve));
      var popOffsetAnimation = secondaryAnimation.drive(popAnimation);

      return SlideTransition(
        position: animation.status == AnimationStatus.reverse
            ? popOffsetAnimation
            : pushOffsetAnimation,
        child: child,
      );
    },
  );
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Forward animation (push)
            var pushAnimation = Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeInOut));
            var pushFadeAnimation = animation.drive(pushAnimation);

            // Reverse animation (pop)
            var popAnimation = Tween(begin: 1.0, end: 0.0)
                .chain(CurveTween(curve: Curves.easeInOut));
            var popFadeAnimation = secondaryAnimation.drive(popAnimation);

            return FadeTransition(
              opacity: animation.status == AnimationStatus.reverse
                  ? popFadeAnimation
                  : pushFadeAnimation,
              child: child,
            );
          },
        );
}
