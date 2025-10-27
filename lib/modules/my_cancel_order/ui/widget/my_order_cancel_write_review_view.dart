import '../../../../utils/exports.dart';

/// Widget that displays a text input field for writing order cancellation comments.
class MyOrderCancelWriteReviewView extends StatelessWidget {
  /// Creates a my order cancel write review view.
  const MyOrderCancelWriteReviewView({
    super.key,
    required this.controller,
    required this.isTitleVisible,
    required this.formKey,
    required this.focusNode,
     this.errorMessage,
    this.device = ScreenType.mobile,
  });

  /// The text editing controller for the comment input.
  final TextEditingController controller;

  /// Whether the title should be visible.
  final bool isTitleVisible;

  /// The form key for validation.
  final GlobalKey<FormState> formKey;

  /// The focus node for the text field.
  final FocusNode? focusNode;

  /// Error message to display if validation fails.
  final String? errorMessage;

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return CommonTextFormFieldWidget(
      errorMsg: errorMessage,
      editTextHeight: Dimens.size242,
      focusNode: focusNode,
      controller: controller,
      maxLength: Dimens.lengthFormatter1000,
      label: context.appString.writeAReviewKey,
      textInputType: TextInputType.multiline,
      input: TextInputAction.done,
      maxLines: Dimens.maxLines09,
    );
  }
}
