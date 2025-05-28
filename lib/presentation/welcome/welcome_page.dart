import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/auth.dart';
import 'icon_background.dart';
import 'onboarding_data.dart';
import 'welcome_provider.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingCompleted = ref.watch(onboardingNotifierProvider);

    return onboardingCompleted.maybeWhen(
      data: (completed) {
        return completed
            ? const LoginPage()
            : const OnboardingScreen();
      },
      orElse:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = pages;

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    await ref.read(onboardingNotifierProvider.notifier).completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(102, 51, 46, 40),

      body: IconBackground(
        child: SafeArea(
            child: Column(
              children: [
                // 🔵 PageView adaptativo
                Expanded(
                  flex: isPortrait ? 7 : 5, // 🔥 Menos flex en horizontal
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 10,
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        final page = _pages[index];
                        return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeIn(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child:
                                        page.lottieAsset != null
                                            ? Lottie.asset(
                                              page.lottieAsset!,
                                              repeat: false,
                                              height: screenHeight * 0.3,
                                              fit: BoxFit.contain,
                                            )
                                            : Image.asset(
                                              page.imageAsset!,
                                              height: screenHeight * 0.25,
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SlideInRight(
                                  child: Column(
                                    children: [
                                      Text(
                                        page.title,
                                        style: TextStyle(
                                          fontSize: isPortrait ? 28 : 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        page.description,
                                        style: TextStyle(
                                          fontSize: isPortrait ? 20 : 18,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
           
                     
                     
                      },
                    ),
                  ),
                ),
        
                // 🔵 SmoothPageIndicator
                const SizedBox(height: 10),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: const WormEffect(
                    dotHeight: 13,
                    dotWidth: 13,
                    activeDotColor: Color.fromRGBO(196, 145, 52, 1),
                    dotColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
        
                // 🔵 Botones Saltar / Siguiente
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: _finishOnboarding,
                        child: const Text(
                          'Saltar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Empezar'
                              : 'Siguiente',
                         
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
      ),
      
      
    );
  }
}
