import 'package:find_any_movie/themes.dart';
import 'package:flutter/material.dart';

class TestSlider extends StatefulWidget {
  const TestSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<TestSlider> createState() => _TestSliderState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TestSliderState extends State<TestSlider> with TickerProviderStateMixin {
  int index = 0;
  late Animation<double> _animation;
  late AnimationController _controller;

  List<Image> images = [
    Image.asset('assets/slider_images/crown.jpg',
        fit: BoxFit.none, height: 450, scale: 3, key: const Key('1')),
    Image.asset('assets/slider_images/last_duel.jpg',
        fit: BoxFit.none, height: 450, scale: 5.8, key: const Key('2')),
    Image.asset('assets/slider_images/saints.jpg',
        fit: BoxFit.none, height: 450, scale: 3, key: const Key('3')),
    Image.asset('assets/slider_images/spider_man.jpg',
        fit: BoxFit.none, height: 450, scale: 3, key: const Key('4')),
    Image.asset('assets/slider_images/bond.jpg',
        fit: BoxFit.none, height: 450, scale: 3, key: const Key('5')),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
    final Animation<double> curve =
        CurvedAnimation(parent: _controller, curve: Curves.linear);
    _animation = Tween<double>(begin: 0, end: 1).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: FilmTheme.backgroundColor,
      body: SizedBox(
        width: width,
        height: 600,
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: width,
              height: 285,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                child: buildImagesIndex(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImagesIndex() {
    if (_controller.value > 0.060) {
      if (_controller.value > 0.25) {
        if (_controller.value > 0.44) {
          if (_controller.value > 0.63) {
            if (_controller.value > 0.82) {
              return images[4];
            }
            return images[3];
          }
          return images[2];
        }
        return images[1];
      }

      return images[0];
    }
    return images[0];
  }
}
