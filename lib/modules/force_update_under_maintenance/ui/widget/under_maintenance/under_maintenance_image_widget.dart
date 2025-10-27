import '../../../../../utils/exports.dart';

/// The class  displays an image based on the
/// `maintenanceImage` property from a `ForceUpdateConfigModel` object, with a
/// placeholder image and specified height.

class UnderMaintenanceImageWidget extends StatelessWidget {
  /// The class  displays an image based on the
  /// `maintenanceImage` property from a `ForceUpdateConfigModel` object, with a
  /// placeholder image and specified height.
  const UnderMaintenanceImageWidget({super.key, this.config});

  ///config model
  final ForceUpdateConfigModel? config;


  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
        child: CustomNetworkImageWidget(
          imageUrl: config?.underMaintenance?.maintainanceImage ?? '',
          placeHolderImage: Assets.svgs.icDukanSplashLogo.svg(),
          fit: BoxFit.contain,
        ),
      );
}
