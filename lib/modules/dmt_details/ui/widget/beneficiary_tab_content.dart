import '../../../../../utils/exports.dart';
import '../../model/beneficiary_model.dart';
import 'add_new_beneficiary_button.dart';
import 'beneficiary_card_widget.dart';

/// Sample list for UI; replace with API/cubit later.


/// Beneficiary tab: "Add New Beneficiary Account" button + ListView of beneficiary cards (UI only).
class BeneficiaryTabContent extends StatelessWidget {
  const BeneficiaryTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.greyExtraLight.withOpacity(0.10),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space20,
          vertical: Dimens.space16,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AddNewBeneficiaryButton(),
          Dimens.space20.heightBox,
          ListView.builder(
            shrinkWrap: true,
            physics:  const NeverScrollableScrollPhysics(),
            itemCount: AppConstant.sampleBeneficiaries.length,
            itemBuilder: (BuildContext context, int index) {
              final BeneficiaryModel item = AppConstant.sampleBeneficiaries[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: Dimens.space12),
                child: BeneficiaryCardWidget(
                  key: ValueKey<String?>(item.id),
                  beneficiary: item,
                ),
              );
            },
          ),
        ],
        ),
      ),
    );
  }
}
