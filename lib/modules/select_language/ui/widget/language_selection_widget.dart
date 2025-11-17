import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';

/// Widget that displays language selection options with English and Arabic buttons.
class LanguageSelectionWidget extends BaseResponsiveView {
  /// Creates a language selection widget.
  const LanguageSelectionWidget({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }

  Widget _buildView(BuildContext context, ScreenType device) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopViewOnboardingLogin(
            device: device,
          ),
          Expanded(
            child: BottomViewOnboardingLogin(
                childWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: Dimens.size50,
                  ),
                  CustomTextLabelWidget(
                    label: AppConstantString.welcomeMsg,
                    style: context.textTheme.titleLarge?.copyWith(
                        height:
                            Dimens.lineHeight28.toLineHeight(Dimens.fontSize24),
                        fontSize: Dimens.fontSize24),
                  ),
                  const SizedBox(
                    height: Dimens.size29,
                  ),
                  CustomTextLabelWidget(
                    label: AppConstantString.selectLanguageEnglish,
                    style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        height:
                            Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                        fontSize: Dimens.fontSize14),
                  ),
                  const SizedBox(
                    height: Dimens.size28,
                  ),
                  CustomTextLabelWidget(
                    label: AppConstantString.selectLanguageArabic,
                    style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        height:
                            Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
                        fontSize: Dimens.fontSize14),
                  ),
                  const SizedBox(
                    height: Dimens.size40,
                  ),
                  CustomGradientButtonWidget(
                      title: AppConstantString.englishText,
                      onTap: () async {
                        final ProviderContainer container = ProviderScope.containerOf(context);
                        await container.read(languageSelectionNotifierProvider.notifier).navigateToLoginScreen(LanguageCode.en);
                      }),
                  const SizedBox(
                    height: Dimens.size24,
                  ),
                  CustomGradientButtonWidget(
                      title: AppConstantString.arabicText,
                      onTap: () async {
                        final ProviderContainer container = ProviderScope.containerOf(context);
                        await container.read(languageSelectionNotifierProvider.notifier).navigateToLoginScreen(LanguageCode.ar);
                      })
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
