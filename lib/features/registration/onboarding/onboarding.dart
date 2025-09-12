import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minders/core/utils/assets/app_frames.dart';
import 'package:minders/core/utils/themes/app_colors.dart';
import 'package:minders/core/utils/themes/app_text_styles.dart';
import 'package:minders/features/creating_habit/views/morning_view.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0), // Both pages move left
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentIndex == 3) {
      // Reset to first page or navigate to login
      setState(() {
        currentIndex = 0;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MorningView()),
      );
    } else {
      _animationController.forward().then((_) {
        setState(() {
          currentIndex++;
        });
        _animationController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBackgroundColor,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        highlightElevation: 0,
        hoverElevation: 0,
        shape: CircleBorder(
          eccentricity: 0.5,
          side: BorderSide(
            color: AppColors.purpleAccent,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: _nextPage,
        child: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.purpleAccent,
          ),
          child: Center(
            child: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: AppColors.whiteTextColors,
            ),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Current page
              SlideTransition(
                position: _slideAnimation,
                child: _onboardingContent(currentIndex),
              ),
              // Next page sliding in from right
              if (_animationController.isAnimating)
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  )),
                  child: _onboardingContent(currentIndex + 1),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _onboardingContent(int index) {
    switch (index % 4) {
      // Use modulo to handle overflow
      case 0:
        return _OnboardingContent(
          title: "Track Your Goal",
          description:
              "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
          image: AppFrames.girl,
        );
      case 1:
        return _OnboardingContent(
          title: "Get Burn",
          description:
              "Let's keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
          image: AppFrames.running,
        );
      case 2:
        return _OnboardingContent(
          title: "Eat Well",
          description:
              "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
          image: AppFrames.grass,
        );
      case 3:
        return _OnboardingContent(
          title: "Morning yoga",
          description:
              "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
          image: AppFrames.meditation,
        );
      default:
        return _OnboardingContent(
          title: "Track Your Goal",
          description:
              "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
          image: AppFrames.girl,
        );
    }
  }
}

class _OnboardingContent extends StatelessWidget {
  const _OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 48,
      children: [
        SvgPicture.asset(image),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.text24w700black),
              Text(
                description,
                style: AppTextStyles.text14w500black.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
