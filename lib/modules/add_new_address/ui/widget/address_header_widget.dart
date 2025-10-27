import '../../../../utils/exports.dart';

/// `AddressHeaderWidget` is a stateful widget that displays the header for the
/// address section, including a map location icon and the address title and
/// subtitle.
class AddressHeaderWidget extends StatefulWidget {
  ///
  const AddressHeaderWidget({super.key});

  @override
  State<AddressHeaderWidget> createState() => _AddressHeaderWidgetState();
}

class _AddressHeaderWidgetState extends State<AddressHeaderWidget> {
  SelectedAddressModel? savedAddress;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      await _loadSavedAddress();
    });
  }

  /// Load saved address from SharedPreferences
  Future<void> _loadSavedAddress() async {
    try {
      final SelectedAddressModel? address = await SharedPref.instance.getSelectedAddress();
      if (address != null && address.isValid) {
        setState(() {
          savedAddress = address;
        });
        DebugLog.instance.i('AddressHeader: Loaded saved address: ${address.title}');
        DebugLog.instance.i('AddressHeader: Loaded saved address: ${address.postalCode}');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('AddressHeader: Error loading saved address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.isEnglishLanguage;

    return Padding(
      padding: const EdgeInsets.only(top: Dimens.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: !isEnglish ? Dimens.size10 : Dimens.size0,
                  // Adjust based on RTL or LTR
                  right: !isEnglish
                      ? Dimens.size0
                      : Dimens.size10, // Adjust based on RTL or LTR
                ),
                child: Assets.svgs.icMapLocation
                    .svg(height: Dimens.size20, width: Dimens.size20),
              ),
              CustomTextLabelWidget(
                textAlign: !isEnglish ? TextAlign.end : TextAlign.start,
                // Adjust text alignment based on RTL or LTR
                style: context.textTheme.titleLarge?.copyWith(
                    height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                    fontSize: Dimens.fontSize16),
                label: savedAddress?.title ?? AppConstant.salmiyahAddress,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size14,
              bottom: Dimens.size20,

            ),
            child: CustomTextLabelWidget(
              overflow: TextOverflow.ellipsis,
              maxLines: Dimens.maxLines02,
              textDirection: TextDirection.ltr,
              style: context.textTheme.titleLarge?.copyWith(
                height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
                fontSize: Dimens.fontSize14,
              ),
              textAlign: !isEnglish ? TextAlign.end : TextAlign.start,
              // Adjust text alignment based on LTR/RTL
              label: savedAddress?.formattedAddress ?? AppConstant.address,
            ),
          ),
        ],
      ),
    );
  }
}
