import '../../../../../utils/exports.dart';

/// Back button with light green rounded square background.
class ServiceDetailsAppBarBackButton extends StatelessWidget {
  const ServiceDetailsAppBarBackButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
       padding: const EdgeInsets.all(Dimens.space6),
        decoration: BoxDecoration(
          color: AppColors.serviceGridGradientDark,
          borderRadius: Dimens.radius4.borderRadius,
        ),
        child: Center(
          child: Assets.svgs.icBack.svg(

          ),
        ),
      ),
    );
  }
}
