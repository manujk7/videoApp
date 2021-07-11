import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_app_flutter/theme.dart';

import 'package:video_player/video_player.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class PlayerDemo extends StatefulWidget {
  final CameraDescription camera;

  const PlayerDemo({
    Key key,
    this.title = 'Chewie Demo',
    this.camera,
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _PlayerDemoState();
  }
}

class _PlayerDemoState extends State<PlayerDemo> {
  TargetPlatform _platform = TargetPlatform.iOS;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  double width = 150.0, height = 150.0;
  Offset position = Offset.zero;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,

      // subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.red,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      fullScreenByDefault: true,
      showControls: true,
      showControlsOnInitialize: true,
      overlay: Positioned(
        right: position.dx,
        bottom: position.dy + 60,
        child: GestureDetector(
          onPanUpdate: (details) {
            // print("pan update");
            setState(() {
              position = Offset(position.dx + details.delta.dx,
                  position.dy + details.delta.dy);
            });
          },
          child: Container(
            width: width,
            height: height,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return RotatedBox(
                      quarterTurns:
                          1 - _controller.description.sensorOrientation ~/ 90,
                      child: CameraPreview(_controller));
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: AppTheme.light.copyWith(
        platform: TargetPlatform.windows,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: _chewieController != null &&
                            _chewieController
                                .videoPlayerController.value.isInitialized
                        ? Chewie(
                            controller: _chewieController,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                              Text('Loading'),
                            ],
                          ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     _chewieController?.enterFullScreen();
                //   },
                //   child: const Text('Fullscreen'),
                // ),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _videoPlayerController1.pause();
                //             _videoPlayerController1.seekTo(const Duration());
                //             _createChewieController();
                //           });
                //         },
                //         child: const Padding(
                //           padding: EdgeInsets.symmetric(vertical: 16.0),
                //           child: Text("Landscape Video"),
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _videoPlayerController2.pause();
                //             _videoPlayerController2.seekTo(const Duration());
                //             // _chewieController = _chewieController.copyWith(
                //             //   videoPlayerController: _videoPlayerController2,
                //             //   autoPlay: true,
                //             //   looping: true,
                //             //   /* subtitle: Subtitles([
                //             //     Subtitle(
                //             //       index: 0,
                //             //       start: Duration.zero,
                //             //       end: const Duration(seconds: 10),
                //             //       text: 'Hello from subtitles',
                //             //     ),
                //             //     Subtitle(
                //             //       index: 0,
                //             //       start: const Duration(seconds: 10),
                //             //       end: const Duration(seconds: 20),
                //             //       text: 'Whats up? :)',
                //             //     ),
                //             //   ]),
                //             //   subtitleBuilder: (context, subtitle) => Container(
                //             //     padding: const EdgeInsets.all(10.0),
                //             //     child: Text(
                //             //       subtitle,
                //             //       style: const TextStyle(color: Colors.white),
                //             //     ),
                //             //   ), */
                //             // );
                //           });
                //         },
                //         child: const Padding(
                //           padding: EdgeInsets.symmetric(vertical: 16.0),
                //           child: Text("Portrait Video"),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _platform = TargetPlatform.android;
                //           });
                //         },
                //         child: const Padding(
                //           padding: EdgeInsets.symmetric(vertical: 16.0),
                //           child: Text("Android controls"),
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _platform = TargetPlatform.iOS;
                //           });
                //         },
                //         child: const Padding(
                //           padding: EdgeInsets.symmetric(vertical: 16.0),
                //           child: Text("iOS controls"),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _platform = TargetPlatform.windows;
                //           });
                //         },
                //         child: const Padding(
                //           padding: EdgeInsets.symmetric(vertical: 16.0),
                //           child: Text("Desktop controls"),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
