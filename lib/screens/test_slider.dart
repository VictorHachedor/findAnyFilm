import 'package:flutter/material.dart';
import '../models/models.dart';

class TestSlider extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FindAnyMoviesPages.testSliderPath,
      key: ValueKey(FindAnyMoviesPages.testSliderPath),
      child: const TestSlider(),
    );
  }

  const TestSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<TestSlider> createState() => _TestSliderState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TestSliderState extends State<TestSlider>
    with TickerProviderStateMixin, SingleTickerProviderStateMixin {
  int index = 0;
  late Animation<double> _animation;
  late AnimationController _controller;

  final images = [
    Image.asset('assets/slider_images/crown.jpg',
        fit: BoxFit.fitHeight, key: const Key('1')),
    Image.asset('assets/slider_images/last_duel.jpg',
        fit: BoxFit.fitHeight, key: const Key('2')),
    Image.asset('assets/slider_images/saints.jpg',
        fit: BoxFit.fitHeight, key: const Key('3')),
    Image.asset('assets/slider_images/spider_man.jpg',
        fit: BoxFit.fitHeight, key: const Key('4')),
    Image.asset('assets/slider_images/bond.jpg',
        fit: BoxFit.fitHeight, key: const Key('5')),
  ];

  final buttons = [
    TextButton(
       key: Key('1'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
          fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150.0, 40.0),
                        ),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(120, 240, 120, 1.0))),
        onPressed: () {},
        child: const Text('In cinemas',
            style: TextStyle(color: Colors.black, fontSize: 17.0))),
    TextButton(
      key: Key('2'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
          fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150.0, 40.0),
                        ),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(120, 240, 120, 1.0))),
        onPressed: () {},
        child: const Text('Watch now',
            style: TextStyle(color: Colors.black, fontSize: 17.0,))),
    TextButton(
      key: Key('3'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
          fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150.0, 40.0),
                        ),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(120, 240, 120, 1.0))),
        onPressed: () {},
        child: const Text('Coming soon',
            style: TextStyle(color: Colors.black, fontSize: 17.0))),
    TextButton(
      key: Key('4'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
          fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150.0, 40.0),
                        ),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(120, 240, 120, 1.0))),
        onPressed: () {},
        child: const Text('Buy to own',
            style: TextStyle(color: Colors.black, fontSize: 17.0))),
    TextButton(
      key: Key('5'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
          fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150.0, 40.0),
                        ),
          backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(120, 240, 120, 1.0))),
        onPressed: () {},
        child: const Text('Watch now',
            style: TextStyle(color: Colors.black, fontSize: 17.0))),
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

  void didSelectSliderButton(TestSlider oldWidget, int buttonNumber) {
    super.didUpdateWidget(oldWidget);
    if (buttonNumber == 1) {
      _controller.duration = const Duration(seconds: 40);
      _controller.value = 0.060;
      _controller.repeat();
    } else if (buttonNumber == 2) {
      _controller.duration = const Duration(seconds: 40);
      _controller.value = 0.25;
      _controller.repeat();
    } else if (buttonNumber == 3) {
      _controller.duration = const Duration(seconds: 40);
      _controller.value = 0.43;
      _controller.repeat();
    } else if (buttonNumber == 4) {
      _controller.duration = const Duration(seconds: 40);
      _controller.value = 0.60;
      _controller.repeat();
    } else if (buttonNumber == 5) {
      _controller.duration = const Duration(seconds: 40);
      _controller.value = 0.82;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 850,
        height: 285,
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: 850,
              height: 285,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                child: buildImagesIndex(),
              ),
            ),
            Column(children: [
              const SizedBox(
                height: 180,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                child: buildButtonsIndex(),
              ),
              SizedBox(
                  width: 320,
                  height: 20,
                  child: Stack(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildGreyButton(1),
                          buildGreyButton(2),
                          buildGreyButton(3),
                          buildGreyButton(4),
                          buildGreyButton(5),
                        ]),
                    SizeTransition(
                      sizeFactor: _animation,
                      axis: Axis.horizontal,
                      axisAlignment: -1,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildGreenButton(1),
                            buildGreenButton(2),
                            buildGreenButton(3),
                            buildGreenButton(4),
                            buildGreenButton(5),
                          ]),
                    ),
                  ])),
              const SizedBox(
                height: 2,
              ),
              Container(
                color: Colors.white,
                height: 30,
                width: 450,
              )
            ])
          ],
        ),
      ),
    );
  }

  Widget buildGreenButton(
    int buttonNumber,
  ) {
    return TextButton(
      child: Text(''),
      onPressed: () {
        didSelectSliderButton(const TestSlider(), buttonNumber);
        setState(() {});
      },
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(const Size(1.0, 1.0)),
          fixedSize: MaterialStateProperty.all<Size>(
            const Size(50.0, 5.0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.lightGreenAccent.shade400)),
    );
  }

  Widget buildGreyButton(
    int buttonNumber,
  ) {
    return TextButton(
      child: Text(''),
      onPressed: () {
        didSelectSliderButton(const TestSlider(), buttonNumber);
        setState(() {});
      },
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(const Size(1.0, 1.0)),
          fixedSize: MaterialStateProperty.all<Size>(
            const Size(50.0, 5.0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey)),
    );
  }

  Widget buildImagesIndex() {
    if (_controller.value > 0.060) {
      if (_controller.value > 0.25) {
        if (_controller.value > 0.43) {
          if (_controller.value > 0.60) {
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

  Widget buildButtonsIndex() {
    if (_controller.value > 0.060) {
      if (_controller.value > 0.25) {
        if (_controller.value > 0.43) {
          if (_controller.value > 0.60) {
            if (_controller.value > 0.82) {
              return buttons[4];
            }
            return buttons[3];
          }
          return buttons[2];
        }
        return buttons[1];
      }

      return buttons[0];
    }
    return buttons[0];
  }
}
