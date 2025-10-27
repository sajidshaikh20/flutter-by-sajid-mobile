import '../../../utils/exports.dart';

/// Page for displaying the Contact Us section.
///
/// This page allows users to view contact information, such as phone numbers,
/// email addresses, WhatsApp contact, and submit inquiries or feedback.
/// It adapts responsively based on the screen size using `BaseResponsiveView`.
@RoutePage()
class ContactUsPage extends BaseResponsiveView {
  ///ContactUsPage
  const ContactUsPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }

 Widget _buildView(BuildContext context, ScreenType device) {
    return BlocProvider<ContactUsCubit>(
      create: (BuildContext context) => ContactUsCubit(
        initialState: ContactUsState(
          writeCommentContoller: TextEditingController(),
          status: BaseStateStatus.initial,
          mobileNumberController: TextEditingController(),
          fullNameController: TextEditingController(),
          emailController: TextEditingController(),
          dateOfBirthController: TextEditingController(),
          editProfileModel: const EditProfileModel(),
          phoneCode: "",
          formKey: GlobalKey<FormState>(),
          fullNameFocusNode: FocusNode(),
          mobileNumberFocusNode: FocusNode(),
          writeCommentFocusNode: FocusNode(),
          emailFocusNode: FocusNode(),
          nationalityFocusNode: FocusNode(),
          dateOfBirthFocusNode: FocusNode(),
        ),
      ),
      child: ContactUsView(device: device),
    );
  }
}
