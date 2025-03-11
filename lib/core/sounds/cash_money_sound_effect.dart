import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:travel_go/core/constant/sounds.dart'; // Import the audioplayers package

class CashMoneySoundEffect extends StatefulWidget {
  const CashMoneySoundEffect({super.key});

  @override
  State<CashMoneySoundEffect> createState() => _CashMoneySoundEffectState();
}

class _CashMoneySoundEffectState extends State<CashMoneySoundEffect> {
  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Create an AudioPlayer instance

  @override
  void initState() {
    super.initState();
    _playCashSound(); // Play the sound when the widget is initialized
  }

  Future<void> _playCashSound() async {
    await _audioPlayer.play(
      AssetSource(Sounds.cashMoney),
    ); // Play the sound
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Return an empty widget since no UI is needed
    return SizedBox.shrink();
  }
}
