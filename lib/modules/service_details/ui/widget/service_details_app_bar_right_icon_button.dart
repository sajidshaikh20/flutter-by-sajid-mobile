import '../../../../../utils/exports.dart';

/// Right-side circular icon (add user) with dark green background.
class ServiceDetailsAppBarRightIconButton extends StatelessWidget {
  const ServiceDetailsAppBarRightIconButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Assets.svgs.icAdd.svg(),
    );
  }
}
