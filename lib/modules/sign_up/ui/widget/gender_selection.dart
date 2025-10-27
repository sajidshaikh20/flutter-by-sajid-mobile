import '../../../../utils/exports.dart';

/// A widget for selecting gender with radio buttons.
/// 
/// This widget provides a UI for users to select their gender
/// with male and female options using radio buttons.
class GenderSelection extends StatefulWidget {
  /// Callback function called when gender selection changes.
  final void Function(String?) onChanged;
  
  /// The initially selected gender value.
  final String? initialValue;
  
  /// Error message to display below the widget.
  final String? errorMessage;

  /// Creates a [GenderSelection] widget.
  const GenderSelection({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.errorMessage,
  });

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialValue;
  }

  @override
  void didUpdateWidget(GenderSelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _selectedGender = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height:Dimens.size58,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
          decoration: BoxDecoration(
            color:MainConfig.appColors.backgroundWhite,
            border: Border.all(
              color: (widget.errorMessage?.isNotEmpty ?? false)
                  ? MainConfig.appColors.errorBorder
                  : AppColors.greyBorderColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimens.size10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Dimens.size12.widthBox,
                  CustomTextLabelWidget(
                    label: context.appString.genderKey,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: Dimens.fontSize16,
                      fontWeight: FontWeight.w400,
                      color: MainConfig.appColors.labelGrey,
                    ),
                  ),
                  Dimens.size33.widthBox,
                  Row(
                    children: <Widget>[
                      SelectableIconRadio(
                          value: AppConstant.male,
                          label: context.appString.maleKey,
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                            widget.onChanged(value);
                          },
                          size: Dimens.size16),
                      Dimens.size39.widthBox,
                      SelectableIconRadio(
                          value: AppConstant.female,
                          label: context.appString.femaleKey,
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                            widget.onChanged(value);
                          },
                          size: Dimens.size16),
                    ],
                  ),
                ],
              ),


            ],
          ),
        ),
        Dimens.size2.heightBox,
        if (widget.errorMessage?.isNotEmpty ?? false) // Show error if provided
          Padding(
            padding:
            const EdgeInsets.only(left: Dimens.space12, top: Dimens.space2),
            child: CustomTextLabelWidget(
              textAlign: TextAlign.start,
              label: widget.errorMessage!,
              style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: Dimens.fontSize10,
                  fontWeight: FontWeight.w400,
                  color: MainConfig.appColors.errorBorder),
            ),
          ),
      ],
    );
  }
}
