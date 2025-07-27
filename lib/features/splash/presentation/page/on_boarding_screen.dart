import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../data/data/on_board_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onBoardData.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  final item = onBoardData[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.03),
                        Image.asset(
                          item.image,
                          height: height * 0.5,
                          width: width * 0.8,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: height * 0.05),
                        Text(
                          item.title,
                          style:Styles.textStyle24bold,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.015),
                        Text(
                          item.description,
                          style:Styles.textStyle16.copyWith(color: AppColors.grey,),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onBoardData.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                  width: _currentIndex == index ? width * 0.05 : width * 0.02,
                  height: height * 0.01,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppColors.pColor
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Container(
                width: double.infinity,
                height: height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_currentIndex == onBoardData.length - 1) {
                      GoRouter.of(context).pushReplacement(AppRouter.kLogin);
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == onBoardData.length - 1 ? 'Start' : 'Next',
                    style: Styles.textStyle18bold.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
