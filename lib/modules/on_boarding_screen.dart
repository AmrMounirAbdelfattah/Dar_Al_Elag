import '../layout/home_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    this.image,
    this.title,
    this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/Doc1.svg',
      title: 'أختار العيادة',
      body: 'أختار اللي يناسبك من مابين أكتر من واحد وعشرين عيادة متخصصة',
    ),
    BoardingModel(
      image: 'assets/images/Doc2.svg',
      title: 'أختار الدكتور',
      body: 'أختار اللي يناسبك من مابين أكتر من دكتور متخصصة',
    ),
    BoardingModel(
      image: 'assets/images/Doc4.svg',
      title: 'أحجز العيادة',
      body: 'أنسي ساعات الأنتظار الطويلة  ',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
              onPressed: () {
                navigateAndFinish(
                  context,
                  HomeLayout(),
                );
              },
              child: Text(
                'تخطي',
                style: TextStyle(color: HexColor("#051DA4")),
              )),
        )
      ], backgroundColor: Colors.transparent, elevation: 0.0),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: HexColor("#D00404"),
                    dotHeight: 10.0,
                    expansionFactor: 4.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: HexColor("#D00404"),
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(
                        context,
                        HomeLayout(),
                      );
                    } else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_back_ios_new),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset('${model.image}'),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: HexColor("#051DA4")),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
