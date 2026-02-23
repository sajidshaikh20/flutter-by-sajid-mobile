import '../../../../utils/exports.dart';



/// Payment success screen: green checkmark, title, transaction details card.
@RoutePage()
class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({
    super.key,
    this.mobileNumber = '9000000000',
    this.availableLimit = '₹25,000',
    this.name = 'Sazid Ahmad',
    this.sendUpTo = '₹25,000',
  });

  final String mobileNumber;
  final String availableLimit;
  final String name;
  final String sendUpTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space20,
            vertical: Dimens.space24,
          ),
          child: Column(
            children: <Widget>[
              Dimens.space40.heightBox,
              Assets.svgs.icPaymentSucess.svg(),
              Dimens.space10.heightBox,
              CustomTextLabelWidget(
                label: 'Payment Successful',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.fontSize20,
                  color: AppColors.blackColor,
                ),
              ),
              Dimens.space70.heightBox,
              TransactionDetailsCard(
                mobileNumber: mobileNumber,
                availableLimit: availableLimit,
                name: name,
                sendUpTo: sendUpTo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



