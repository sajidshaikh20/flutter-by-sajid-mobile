import '../../../../../utils/exports.dart';
import 'info_row_widget.dart';

/// Customer info card: white card with label-value rows and dividers.
class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    required this.mobileNumber,
    required this.availableLimit,
    required this.name,
    required this.sendUpTo,
  });

  final String mobileNumber;
  final String availableLimit;
  final String name;
  final String sendUpTo;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimens.radius10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.06),
            offset: const Offset(Dimens.space0, Dimens.space4),
            blurRadius: Dimens.blurRadius10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InfoRowWidget(label: 'Mobile Number', value: mobileNumber),
          const DottedDivider(indent: Dimens.space10, endIndent: Dimens.space10),
          InfoRowWidget(label: 'Available Limit', value: availableLimit),
          const DottedDivider(indent: Dimens.space10, endIndent: Dimens.space10),
          InfoRowWidget(label: 'Name', value: name, valueBold: true),
          const DottedDivider(indent: Dimens.space10, endIndent: Dimens.space10),
          InfoRowWidget(label: 'You Can Send Up To', value: sendUpTo),
        ],
      ),
    );
  }
}
