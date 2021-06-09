import 'package:flutter/material.dart';

class Home extends StatefulWidget {

    @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedBuilder"),),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Image.asset(
            'assets/images/stars.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              return ClipPath(
                clipper: const BeamClipper(),
                child: Container(
                  height: 1000,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: 1.5,
                      colors: [
                        Colors.yellow,
                        Colors.transparent,
                      ],
                      stops: [0, _animationController.value],
                    ),
                  ),
                ),
              );
            },
          ),
          Image.asset('assets/images/ufo.png'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}