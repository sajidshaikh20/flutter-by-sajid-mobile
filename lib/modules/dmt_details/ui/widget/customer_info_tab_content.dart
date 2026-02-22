import '../../../../../utils/exports.dart';
import 'info_card_widget.dart';

/// Customer Info tab: shows customer info card (mobile, limit, name, send up to).
class CustomerInfoTabContent extends StatelessWidget {
  const CustomerInfoTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  ColoredBox(
      color: AppColors.greyExtraLight.withOpacity(0.10),
      child: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.space20,
          vertical: Dimens.space16,
        ),
        child: InfoCardWidget(
          mobileNumber: '9000000000',
          availableLimit: '₹25,000',
          name: 'Sazid Ahmad',
          sendUpTo: '₹25,000',
        ),
      ),
    );
  }
}
