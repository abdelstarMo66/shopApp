import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../sheared/network/local/cashe_helper.dart';
import 'login/login.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<BoardingModel> Boarding = [
  BoardingModel(
    image: 'assets/images/Shoping.jpg',
    title: 'Shopping',
    body: 'Everything you needing in one place',
  ),
  BoardingModel(
    image: 'assets/images/shoping2.jpg',
    title: 'Coming Here',
    body: 'Enjoy you and your family at cheap prices',
  ),
  BoardingModel(
    image: 'assets/images/VisaCard.jpg',
    title: 'Payment Facilities',
    body: 'You can now pay with Visa Card',
  ),
];

bool lastIndex = false;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var control = PageController();
    void Submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login_Screen()),
            (Route<dynamic> route) => false,
          );
        }
      });
    }

    Func(int index) {
      if (index == Boarding.length - 1) {
        setState(() {
          lastIndex = true;
        });
        print(lastIndex);
      } else {
        setState(() {
          lastIndex = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: Func,
                itemBuilder: (context, index) => BordingItem(Boarding[index]),
                itemCount: Boarding.length,
                physics: const BouncingScrollPhysics(),
                controller: control,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            SmoothPageIndicator(
                controller: control, // PageController
                count: Boarding.length,
                effect: const JumpingDotEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  jumpScale: .7,
                  verticalOffset: 15,
                  activeDotColor: Colors.teal,
                ), // your preferred effect
                onDotClicked: (index) {}),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Submit();
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // print(lastIndex);
                      if (lastIndex) {
                        Submit();
                      } else {
                        control.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.easeInOutExpo,
                        );
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget BordingItem(BoardingModel model) => Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          model.body,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
