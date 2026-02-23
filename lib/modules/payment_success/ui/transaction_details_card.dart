

import '../../../utils/exports.dart';

class TransactionDetailsCard extends StatelessWidget {
  const TransactionDetailsCard({super.key,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: Dimens.space20,horizontal: Dimens.space10),
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundSuccessColor,
        borderRadius: BorderRadius.circular(Dimens.radius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextLabelWidget(
            label: 'Transactions Details',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: Dimens.fontSize16,
              color: AppColors.blackColor,
            ),
          ),

          InfoRowWidget(label: 'Mobile Number', value: mobileNumber),
          const DottedDivider(),
          InfoRowWidget(label: 'Available Limit', value: availableLimit),
          const DottedDivider(),
          InfoRowWidget(label: 'Name', value: name),
          const DottedDivider(),
          InfoRowWidget(label: 'You Can Send Up To', value: sendUpTo),
        ],
      ),
    );
  }
}