import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../locales.dart';


class VideosPlayerPage extends StatefulWidget {
  const VideosPlayerPage({super.key});

  @override
  State<VideosPlayerPage> createState() => _VideosPlayerPageState();
}

class _VideosPlayerPageState extends State<VideosPlayerPage> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  bool _isFullScreen = false; // Flag for fullscreen mode

  VideoPlayerController? _controller;

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
    try {
      final response = await http.get(Uri.parse('https://drive.usercontent.google.com/download?id=1QFwCcbSAB76yJgMXHfK9s92km9GX-ZAa&export=download&confirm=t/backend/videos')); // replace with your actual endpoint
      if (response.statusCode == 200) {
        setState(() {
          videoInfo = json.decode(response.body);
        });
      } else {
        print('Failed to load videos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://drive.google.com/uc?export=download&id=14uFw7tzl4k61EEfDesriTvx_BINNd-wm',
    )..initialize().then((_) {
      setState(() {});
      _controller?.play();
    });
    _initData();
  }
  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;

      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });
  }


  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(color: Colors.grey[200])
            : const BoxDecoration(color: Colors.white54),
        child: Column(
          children: [
            _playArea == false
                ? Container(
              padding: const EdgeInsets.only(top: 70, left: 5, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(color: Colors.black),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            )
                : Column(
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(top: 50, left: 10, right: 30),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: const BackButton()),
                    ],
                  ),
                ),
                _playView(context),
                _controlView(context),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          LocaleData.body77.getString(context),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(child: _listView()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value?.volume ?? 0) > 0;
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 5),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(50, 0, 0, 0),
                    ),
                  ],
                ),
                child: Icon(
                  noMute ? Icons.volume_up : Icons.volume_off,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            onTap: () {
              if (noMute) {
                _controller?.setVolume(0);
              } else {
                _controller?.setVolume(1.0);
              }
              setState(() {});
            },
          ),
          TextButton(
            onPressed: () async {
              final index = _isPlayingIndex + 1;
              if (index <= videoInfo.length - 1) {
                _onTapVideo(index);
              }
            },
            child: Icon(
              Icons.fast_rewind,
              size: 30,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_isPlaying) {
                setState(() {
                  _isPlaying = false;
                });
                _controller?.pause();
              } else {
                setState(() {
                  _isPlaying = true;
                });
                _controller?.play();
              }
            },
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 30,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () async {
              final index = _isPlayingIndex + 1;
              if (index <= videoInfo.length - 1) {
                _onTapVideo(index);
              }
            },
            child: Icon(
              Icons.fast_forward,
              size: 30,
              color: Colors.black,
            ),
          ),
          // Fullscreen toggle icon
          IconButton(
            icon: Icon(
              _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
              size: 30,
              color: Colors.black,
            ),
            onPressed: _toggleFullScreen,
          ),
        ],
      ),
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator()), // Loading icon
      );
    }
  }

  var _onUpdateControllerTime;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }

    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can't be initialized");
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onTapVideo(int index) {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(videoInfo[index]["videoUrl"]),
    );
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});

    controller.initialize().then((_) {
      old?.dispose();
      _isPlayingIndex = index;
      controller.addListener(_onControllerUpdate);
      controller.play();
      setState(() {});
    });
  }

  _listView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      itemCount: videoInfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _onTapVideo(index);
              if (_playArea == false) {
                _playArea = true;
              }
            });
          },
          child: _buildCard(index),
        );
      },
    );
  }

  _buildCard(int index) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(videoInfo[index]["thumbnail"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]["Coursetype"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    videoInfo[index]["title"],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  FavoritesManager().favoriteVideos.any((v) => v['title'] == videoInfo[index]["title"])
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: FavoritesManager().favoriteVideos.any((v) => v['title'] == videoInfo[index]["title"])
                      ? Colors.red
                      : Colors.black,
                ),

                onPressed: () {
                  setState(() {
                    final video = {
                      "Coursetype": videoInfo[index]["Coursetype"],
                      "title": videoInfo[index]["title"],
                      "thumbnail": videoInfo[index]["thumbnail"],
                      "videoUrl": videoInfo[index]["videoUrl"]
                    };
                    if (FavoritesManager().favoriteVideos.contains(video)) {
                      FavoritesManager().removeFavorite(video);
                    } else {
                      FavoritesManager().addFavorite(video);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();

  factory FavoritesManager() {
    return _instance;
  }

  FavoritesManager._internal();

  List<Map<String, dynamic>> favoriteVideos = [];

  void addFavorite(Map<String, dynamic> video) {
    if (!favoriteVideos.contains(video)) {
      favoriteVideos.add(video);
    }
  }

  void removeFavorite(Map<String, dynamic> video) {
    favoriteVideos.remove(video);
  }
}
