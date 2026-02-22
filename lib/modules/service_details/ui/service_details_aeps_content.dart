import '../../../../utils/exports.dart';

/// AEPS Aadhaar Pay flow content for the service details screen.
class ServiceDetailsAepsContent extends StatelessWidget {
  const ServiceDetailsAepsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space20),
        child: CustomTextLabelWidget(
          label: 'AEPS Aadhaar Pay flow – add your screens here.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: MainConfig.appColors.textBlackColor,
          ),
        ),
      ),
    );
  }
}
