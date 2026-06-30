import '../../../../utils/exports.dart';

/// Screen widget containing the PageView and UI for onboarding screens.
class OnboardingScreen extends StatelessWidget {
  /// Creates the onboarding screen.
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  Widget _buildDot(int index, int currentPage) {
    final bool isActive = currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryPurple
            : Colors.white.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
    );
  }

  // Reusable structure for page templates showing mockup images
  Widget _buildImagePage({
    required String title,
    required String gradientSubtitle,
    required String description,
    required Widget image,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Column(
      children: <Widget>[
        // Text header section with specific padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: Dimens.space10),
              CustomTextLabelWidget(
                label: title,
                style: TextStyle(
                  fontSize: Dimens.fontSize28,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: Dimens.space4),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppColors.primaryButtonGradient.createShader(
                    Offset.zero & bounds.size,
                  );
                },
                child: CustomTextLabelWidget(
                  label: gradientSubtitle,
                  style: const TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space12),
              CustomTextLabelWidget(
                label: description,
                style: TextStyle(
                  fontSize: Dimens.fontSize16,
                  color: textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimens.space24),
        // Expanded layout for image without horizontal padding limits to make it larger/immense
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size12),
            child: Center(
              child: image,
            ),
          ),
        ),
      ],
    );
  }

  // Page 1: Trade Smarter with Expert Signals
  Widget _buildPageOne(Color textPrimary, Color textSecondary) {
    return _buildImagePage(
      title: 'Trade Smarter with',
      gradientSubtitle: 'Expert Signals',
      description: 'Get high-quality trade ideas from professional traders.',
      image: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.16),
              blurRadius: 40,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Assets.png.icOnboard1.image(
          fit: BoxFit.contain,
        ),
      ),
      textPrimary: textPrimary,
      textSecondary: textSecondary,
    );
  }

  // Page 2: Analytical Insights / Calculator Tools
  Widget _buildPageTwo(Color textPrimary, Color textSecondary) {
    return _buildImagePage(
      title: 'Manage Your Risk with',
      gradientSubtitle: 'Trading Tools',
      description: 'Use our compound calculator and PIP tool to stay ahead of the market.',
      image: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.16),
              blurRadius: 40,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Assets.png.icOnboard2.image(
          fit: BoxFit.contain,
        ),
      ),
      textPrimary: textPrimary,
      textSecondary: textSecondary,
    );
  }

  // Page 3: App logo / Welcome to Weko Pro page
  Widget _buildPageThree(Color textPrimary, Color textSecondary) {
    return _buildImagePage(
      title: 'All-in-One Platform',
      gradientSubtitle: 'Weko Pro',
      description: 'Your ultimate hub for trading journal tracking and analytical insights.',
      image: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.25),
              blurRadius: 40,
              spreadRadius: 8,
            ),
          ],
        ),
        child: Assets.png.icCropWekoIcon.image(
          height: 180.0,
          width: 180.0,
          fit: BoxFit.contain,
        ),
      ),
      textPrimary: textPrimary,
      textSecondary: textSecondary,
    );
  }

  // Page 4: Replicating User Screenshot Design (Features details)
  Widget _buildPageFour(Color textPrimary, Color textSecondary) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: Dimens.space10),
            // Header: Built for Traders
            CustomTextLabelWidget(
              label: 'Built for Traders',
              style: TextStyle(
                fontSize: Dimens.fontSize32,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: Dimens.space4),
            // Gradient: Like You
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.primaryButtonGradient.createShader(
                  Offset.zero & bounds.size,
                );
              },
              child: const CustomTextLabelWidget(
                label: 'Like You',
                style: TextStyle(
                  fontSize: Dimens.fontSize32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White lets gradient overlay show
                ),
              ),
            ),
            const SizedBox(height: Dimens.space16),
            // Subtitle Description
            CustomTextLabelWidget(
              label:
                  "Whether you're just starting or a pro, Weko Pro is built to grow with your journey.",
              style: TextStyle(
                fontSize: Dimens.fontSize16,
                color: textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.space40),

            // Features List
            _buildFeatureRow(
              icon: Icons.emoji_events_outlined,
              iconColor: const Color(0xFF8B40FF),
              title: 'For Every Trader',
              subtitle: 'Perfect for beginners and experienced traders',
              textPrimary: textPrimary,
              textSecondary: textSecondary,
            ),
            const SizedBox(height: Dimens.space24),
            _buildFeatureRow(
              icon: Icons.shield_outlined,
              iconColor: const Color(0xFF2196F3),
              title: 'Secure & Reliable',
              subtitle: 'Your data and funds are always protected',
              textPrimary: textPrimary,
              textSecondary: textSecondary,
            ),
            const SizedBox(height: Dimens.space24),
            _buildFeatureRow(
              icon: Icons.restore_rounded,
              iconColor: const Color(0xFF00E676),
              title: 'Always Evolving',
              subtitle: 'We keep improving to give you the best experience',
              textPrimary: textPrimary,
              textSecondary: textSecondary,
            ),
            const SizedBox(height: Dimens.space40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Premium glassmorphic style circle with glow
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withValues(alpha: 0.12),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: iconColor.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 26,
          ),
        ),
        const SizedBox(width: Dimens.space18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextLabelWidget(
                label: title,
                style: TextStyle(
                  fontSize: Dimens.fontSize18,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              CustomTextLabelWidget(
                label: subtitle,
                style: TextStyle(
                  fontSize: Dimens.fontSize14,
                  color: textSecondary,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingCubit cubit = context.read<OnboardingCubit>();

    // Dark theme values for premium look
    const Color textPrimary = AppColors.textPrimaryDark;
    const Color textSecondary = AppColors.textSecondaryDark;

    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (OnboardingState previous, OnboardingState current) =>
          current.redirectRoute != null,
      listener: (BuildContext context, OnboardingState state) async {
        if (state.redirectRoute != null) {
          await context.router.replaceAll(<PageRouteInfo>[
            state.redirectRoute!,
          ]);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Premium Dark Mesh/Aurora Gradient Background
            Container(color: const Color(0xFF030511)),
            
            // Top-right glowing violet orb
            Positioned(
              top: -120,
              right: -120,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: <Color>[
                      const Color(0xFF8B40FF).withValues(alpha: 0.16),
                      const Color(0xFF8B40FF).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom-left glowing orange/pink orb
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: <Color>[
                      const Color(0xFFFF4F0B).withValues(alpha: 0.1),
                      const Color(0xFFFF4F0B).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            SafeArea(
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                buildWhen: (OnboardingState previous, OnboardingState current) =>
                    previous.currentPage != current.currentPage,
                builder: (BuildContext context, OnboardingState state) {
                  return Column(
                    children: <Widget>[
                      // Header (Skip Button)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.size20,
                          vertical: Dimens.size10,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: state.currentPage < 3
                              ? TextButton(
                                  onPressed: () async {
                                    await cubit.completeOnboarding();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: textSecondary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.size12,
                                      vertical: Dimens.size8,
                                    ),
                                  ),
                                  child: const CustomTextLabelWidget(
                                    label: 'Skip',
                                    style: TextStyle(
                                      fontSize: Dimens.fontSize16,
                                      fontWeight: FontWeight.w600,
                                      color: textSecondary,
                                    ),
                                  ),
                                )
                              : const SizedBox(height: Dimens.size40),
                        ),
                      ),
                      // Page Content
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (int page) {
                            cubit.updatePage(page);
                          },
                          children: <Widget>[
                            _buildPageOne(textPrimary, textSecondary),
                            _buildPageTwo(textPrimary, textSecondary),
                            _buildPageThree(textPrimary, textSecondary),
                            _buildPageFour(textPrimary, textSecondary),
                          ],
                        ),
                      ),
                      // Bottom Section: Dots and Action Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.size24,
                          vertical: Dimens.size24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Dots Indicator
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List<Widget>.generate(
                                4,
                                (int index) => _buildDot(index, state.currentPage),
                              ),
                            ),
                            const SizedBox(height: Dimens.space24),
                            // Action Button with Gradient and right arrow
                            CustomButtonWidget(
                              title: '',
                              onTap: () async {
                                await cubit.nextPage(_pageController);
                              },
                              isPrimaryButton: true,
                              borderRadius: Dimens.radius16,
                              height: Dimens.size54,
                              childWidget: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CustomTextLabelWidget(
                                    label: state.currentPage == 3
                                        ? 'Get Started'
                                        : 'Next',
                                    style: const TextStyle(
                                      fontSize: Dimens.fontSize16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    right: Dimens.size20,
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: Dimens.size20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
