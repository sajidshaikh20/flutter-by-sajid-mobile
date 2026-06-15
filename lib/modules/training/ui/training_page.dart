import '../../../utils/exports.dart';

@RoutePage()
class TrainingPage extends BaseResponsiveView {
  const TrainingPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
          onPressed: () => context.router.back(),
        ),
        title: CustomTextLabelWidget(
          label: 'Training',
          style: TextStyle(
            color: textColor,
            fontSize: Dimens.fontSize18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: CustomTextLabelWidget(
          label: 'Training Page',
          style: TextStyle(
            color: textColor,
            fontSize: Dimens.fontSize24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
