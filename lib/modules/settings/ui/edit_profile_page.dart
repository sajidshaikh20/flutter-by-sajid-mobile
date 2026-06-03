import '../../../utils/exports.dart';
@RoutePage()
/// Page for editing user profile details.
class EditProfilePage extends BaseResponsiveView {
  const EditProfilePage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  Widget _buildView(BuildContext context) {
    return const EditProfileForm();
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _phoneFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final UserProfileService profileService = UserProfileService.instance();
    
    // Initialize fields with existing user data
    _nameController = TextEditingController(text: profileService.customerName);
    _usernameController = TextEditingController(text: profileService.username.isNotEmpty ? profileService.username : profileService.customerName.toLowerCase().replaceAll(' ', ''));
    _emailController = TextEditingController(text: profileService.customerEmail);
    _phoneController = TextEditingController(text: profileService.phoneNumber);

    _nameFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    _nameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _onTapCamera() {
    unawaited(showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        final bool isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(Dimens.space24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius24),
              topRight: Radius.circular(Dimens.radius24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: Dimens.size40,
                height: Dimens.size4,
                margin: const EdgeInsets.only(bottom: Dimens.space20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black26,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showMockPhotoSuccess();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showMockPhotoSuccess();
                },
              ),
            ],
          ),
        );
      },
    ));
  }


  void _showMockPhotoSuccess() {
    context.scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Profile photo updated successfully! (Mocked)'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String name = _nameController.text.trim();
      final String username = _usernameController.text.trim();
      final String email = _emailController.text.trim();
      final String phone = _phoneController.text.trim();


      await UserProfileService.instance().updateUserProfile(
        customerName: name,
        username: username,
        customerEmail: email,
        phoneNumber: phone,
      );

      if (mounted) {
        context.scaffoldMessenger.showSnackBar(
          SnackBar(
            backgroundColor: AppColors.successColor,
            content: Text(
              context.appString.editProfileSuccessKey,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
        context.router.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color tileColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color inputFieldBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Premium Header custom implementation
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space16,
                vertical: Dimens.space12,
              ),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => context.router.back(),
                    child: Container(
                      padding: const EdgeInsets.all(Dimens.space8),
                      decoration: BoxDecoration(
                        color: tileColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: textColor,
                        size: Dimens.size16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      child: Padding(
                        padding: const EdgeInsets.only(right: Dimens.size32), // compensate back button width for perfect centering

                        child: CustomTextLabelWidget(
                          label: context.appString.editProfileTitleKey,
                          style: TextStyle(
                            fontSize: Dimens.fontSize18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: Dimens.space16),


                      // Avatar with Neon Gradient ring
                      Stack(
                        children: <Widget>[
                          Container(
                            width: Dimens.size110,
                            height: Dimens.size110,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: AppColors.primaryGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: backgroundColor,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: ClipOval(
                                child: Image.asset(
                                  Assets.png.icUserImage.path,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: _onTapCamera,
                              child: Container(
                                width: Dimens.size32,
                                height: Dimens.size32,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: AppColors.secondaryGradient,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: Dimens.size16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.space12),
                      CustomTextLabelWidget(
                        label: context.appString.editProfileTapToChangePhotoKey,
                        style: TextStyle(
                          fontSize: Dimens.fontSize13,
                          color: subtitleColor,
                        ),
                      ),

                      const SizedBox(height: Dimens.space28),

                      // Name Field
                      CustomTextFormFieldInputWidget(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        title: context.appString.editProfileNameLabelKey,
                        fillColor: inputFieldBg,
                        borderColor: borderCol,
                        style: TextStyle(color: textColor),
                        titleStyle: TextStyle(
                          color: subtitleColor,
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (dynamic value) {
                          final String val = (value as String?) ?? '';
                          if (val.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: Dimens.space20),

                      // Username Field
                      CustomTextFormFieldInputWidget(
                        controller: _usernameController,
                        focusNode: _usernameFocusNode,
                        title: context.appString.editProfileUsernameLabelKey,
                        fillColor: inputFieldBg,
                        borderColor: borderCol,
                        style: TextStyle(color: textColor),
                        titleStyle: TextStyle(
                          color: subtitleColor,
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (dynamic value) {
                          final String val = (value as String?) ?? '';
                          if (val.trim().isEmpty) {
                            return 'Please enter a username';
                          }
                          if (val.length < 3 || val.contains(' ')) {
                            return 'Min 3 chars, no spaces';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: Dimens.space20),

                      // Email Field
                      CustomTextFormFieldInputWidget(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        title: context.appString.editProfileEmailLabelKey,
                        fillColor: inputFieldBg,
                        borderColor: borderCol,
                        style: TextStyle(color: textColor),
                        titleStyle: TextStyle(
                          color: subtitleColor,
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (dynamic value) {
                          final String val = (value as String?) ?? '';
                          if (val.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          final String? emailError = val.validateEmail(
                            isOnlyEmail: true,
                            enterMobileOrNumberMsg: 'Enter email',
                            enterEmailMsg: 'Enter email',
                            validEmailMsg: 'Enter a valid email address',
                          );
                          if (emailError != null && emailError.isNotEmpty) {
                            return emailError;
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: Dimens.space20),

                      // Phone Field
                      CustomTextFormFieldInputWidget(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        title: context.appString.editProfilePhoneLabelKey,
                        fillColor: inputFieldBg,
                        borderColor: borderCol,
                        style: TextStyle(color: textColor),
                        titleStyle: TextStyle(
                          color: subtitleColor,
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (dynamic value) {
                          final String val = (value as String?) ?? '';
                          if (val.trim().isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: Dimens.space32),

                      // Update Profile Button
                      CustomButtonWidget(
                        title: context.appString.editProfileUpdateBtnKey,
                        onTap: _updateProfile,
                        borderRadius: Dimens.radius10,
                      ),

                      const SizedBox(height: Dimens.space24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
