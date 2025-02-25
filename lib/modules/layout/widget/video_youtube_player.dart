// import 'package:flutter/material.dart';
// import 'package:iqplayer/iqplayer.dart';
//
// class VideoYoutubePlayer extends StatefulWidget {
//   final String link; // YouTube video link
//
//   const VideoYoutubePlayer({
//     super.key,
//     required this.link,
//   });
//
//   @override
//   _VideoYoutubePlayerState createState() => _VideoYoutubePlayerState();
// }
//
// class _VideoYoutubePlayerState extends State<VideoYoutubePlayer> {
//   late IqPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize the IqPlayerController
//     _controller = IqPlayerController(
//       videoPlayerController: VideoPlayerController.network(widget.link),
//     )..initialize();
//   }
//
//   @override
//   void dispose() {
//     // Dispose the controller when the widget is disposed
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("YouTube Video Player"),
//       ),
//       body: Column(
//         children: [
//           // Display the IqPlayer
//           IqPlayer(
//             controller: _controller,
//           ),
//         ],
//       ),
//     );
//   }
// }