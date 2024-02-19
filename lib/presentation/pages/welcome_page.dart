import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:tasks_app/presentation/pages/tabs_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool firstOpen = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!firstOpen) {
        _onIntroEnd(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      pageColor: Color.fromARGB(255, 102, 179, 221),
      imagePadding: EdgeInsets.zero,
    );

    return firstOpen
        ? IntroductionScreen(
            globalBackgroundColor: Color.fromARGB(255, 102, 179, 221),
            globalHeader: Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16),
                  //child: _buildImage('1.json', 50),
                ),
              ),
            ),
            pages: [
              PageViewModel(
                title: '\nPlan you task every day',
                body: 'Create Tasks and keep being updated',
                image: _buildImage('1.json'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: '\nSave your time',
                body:
                    'by using this app you will have more than 24 hours in day',
                image: _buildImage('2.json'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: '\nObserve your progress ',
                body: ' Manage your projects and tasks easily  ',
                image: _buildImage("3.json"),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            onSkip: () =>
                _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipOrBackFlex: 0,
            nextFlex: 0,
            skip: const Text(
              'Skip',
              style: TextStyle(color: Colors.white),
            ),
            next: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            done: const Text("Start",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white)),
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: const EdgeInsets.all(4),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Colors.white,
              activeSize: Size(22.0, 10.0),
              activeColor: Color.fromARGB(255, 154, 189, 208),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            dotsContainerDecorator: const ShapeDecoration(
              color: Color.fromARGB(255, 0, 51, 79),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          )
        : TabsPage();
  }

  _onIntroEnd(context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TabsPage()));
  }

  _buildImage(String assetName, [double width = 350]) {
    return Lottie.asset('assets/$assetName', width: width);
  }
}
