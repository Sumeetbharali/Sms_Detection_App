import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionPages extends StatefulWidget {
  @override
  _IntroductionPagesState createState() => _IntroductionPagesState();
}

class _IntroductionPagesState extends State<IntroductionPages> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            children: <Widget>[
              _buildPage(
                animation: 'assets/Animation - 1720966027859.json',
                text: 'Welcome to our app!',
              ),
              _buildPage(
                animation: 'assets/Animation - 1720964666989.json',
                text: 'Send all the message to the server and view it.',
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/land');
                  },
                  child: Text('Skip'),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 2,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_controller.page == 1) {
                      Navigator.pushReplacementNamed(context, '/land');
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({required String animation, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Lottie.asset(
          animation,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
