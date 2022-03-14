import 'package:find_any_movie/themes.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen({Key? key, required this.youtubeKey}) : super(key: key);
  final String? youtubeKey;

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey ?? '',
      flags: const YoutubePlayerFlags(
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
            progressIndicatorColor: FilmTheme.acidGreenColor,
            controller: _controller,
            showVideoProgressIndicator: true,
            progressColors: const ProgressBarColors(
              playedColor: FilmTheme.acidGreenColor,
              handleColor: FilmTheme.acidGreenColor,
            )),
        builder: (context, player) {
          return Scaffold(
              backgroundColor: FilmTheme.backgroundColor,
              appBar: AppBar(
                backgroundColor: FilmTheme.barBackgroundColor,
                title: const Text('Trailer'),
                centerTitle: true,
              ),
              body: Center(
                child: player,
              ));
        });
  }
}
