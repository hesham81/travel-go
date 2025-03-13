import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/core/constant/soundEffects.dart';
import '/core/extensions/extensions.dart';

class ConfirmUserReservations extends StatefulWidget {
  const ConfirmUserReservations({super.key});

  @override
  State<ConfirmUserReservations> createState() =>
      _ConfirmUserReservationsState();
}

class _ConfirmUserReservationsState extends State<ConfirmUserReservations>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;
  final AudioPlayer player = AudioPlayer();
  bool _showLottie = false; // State variable to control Lottie visibility

  Future<void> _playSounds() async {
    await player.play(
      AssetSource(SoundEffects.flightEffect),
    );
  }

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 12), // Animation duration
    );

    animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Start from the left
      end: Offset(1.0, 0.0), // Move to the right
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear, // Linear animation
      ),
    );

    // Listen for animation status changes
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // When animation completes, update the state to show Lottie
        setState(() {
          _showLottie = true;
        });
      }
    });

    // Start the animation
    controller.forward();

    // Play the sound effect
    _playSounds();
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.3.height.hSpace,
            if (_showLottie)
              Lottie.asset(
                  "assets/images/confirm.json",
                  repeat: false
              ),

            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    animation.value.dx * MediaQuery.of(context).size.width,
                    0,
                  ),
                  child: child,
                );
              },
              child: Image.asset(
                "assets/images/flying_image.jpg",
              ).allPadding(100),
            ),

          ],
        ),
      ),
    );
  }
}
