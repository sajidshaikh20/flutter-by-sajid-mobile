import '../../../../utils/exports.dart';

/// DMT flow content for the service details screen.
class ServiceDetailsDmtContent extends StatelessWidget {
  const ServiceDetailsDmtContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space20),
        child: CustomTextLabelWidget(
          label: 'DMT flow – add your screens here.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: MainConfig.appColors.textBlackColor,
          ),
        ),
      ),
    );
  }
}
