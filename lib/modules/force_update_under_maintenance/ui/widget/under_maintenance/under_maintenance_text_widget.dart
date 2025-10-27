import '../../../../../utils/exports.dart';

/// The class  displays maintenance title and
/// description based on the provided `ForceUpdateConfigModel` configuration.

class UnderMaintenanceTextWidget extends StatelessWidget {

  /// The class  displays maintenance title and

  const UnderMaintenanceTextWidget({super.key, this.config});
  /// config model model ForceUpdateConfigModel

  final ForceUpdateConfigModel? config;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextLabelWidget(
              label: config?.underMaintenance?.maintainanceTitle ?? '',
              style: MainConfig.textTheme.titleLarge,
            ),
            const SizedBox(height: Dimens.space20),
            CustomTextLabelWidget(
              label: config?.underMaintenance?.maintainanceDescription ?? '',
              style: MainConfig.textTheme.bodyMedium,
            ),
          ],
        ),
      );
}
