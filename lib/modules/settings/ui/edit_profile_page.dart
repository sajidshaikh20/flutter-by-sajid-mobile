import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/exports.dart';
import '../../../app/core/widgets/profile_image_preview_page.dart';
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
  final ProfileRepository _profileRepository = ProfileRepositoryImpl();

  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _phoneFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;

  String _originalName = '';
  String _originalUsername = '';
  String _originalEmail = '';
  String _originalPhone = '';
  String _originalCountryDialCode = '+91';
  String _countryDialCode = '+91';
  String _countryIsoCode = 'IN';
  String _phoneErrorMsg = '';

  void _onFieldChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  bool _hasChanges() {
    return _nameController.text.trim() != _originalName ||
        _usernameController.text.trim() != _originalUsername ||
        _emailController.text.trim() != _originalEmail ||
        _phoneController.text.trim() != _originalPhone ||
        _countryDialCode != _originalCountryDialCode ||
        _selectedImage != null;
  }

  @override
  void initState() {
    super.initState();
    final UserProfileService profileService = UserProfileService.instance();
    
    // Initialize fields with existing user data
    _nameController = TextEditingController(text: profileService.customerName);
    _usernameController = TextEditingController(text: profileService.username.isNotEmpty ? profileService.username : profileService.customerName.toLowerCase().replaceAll(' ', ''));
    _emailController = TextEditingController(text: profileService.customerEmail);
    _phoneController = TextEditingController(text: profileService.phoneNumber);

    _originalName = profileService.customerName;
    _originalUsername = profileService.username.isNotEmpty ? profileService.username : profileService.customerName.toLowerCase().replaceAll(' ', '');
    _originalEmail = profileService.customerEmail;
    _originalPhone = profileService.phoneNumber;

    _countryDialCode = profileService.prefix.toString().isNotEmpty 
        ? profileService.prefix.toString() 
        : '+91';
    if (!_countryDialCode.startsWith('+') && _countryDialCode.isNotEmpty) {
      _countryDialCode = '+$_countryDialCode';
    }
    _originalCountryDialCode = _countryDialCode;

    _nameController.addListener(_onFieldChanged);
    _usernameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);

    _nameFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      unawaited(_fetchProfileFromServer());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final List<CountryCode> countries = loadLocalizedCountryCodes(context);
      final CountryCode? match = countries.firstWhereOrNull(
        (CountryCode country) => country.dialCode == _countryDialCode,
      );
      if (match != null) {
        _countryIsoCode = match.code ?? 'IN';
      }
    } on Object catch (e) {
      DebugLog.instance.e('Error loading country codes in didChangeDependencies: $e');
    }
  }

  Future<void> _fetchProfileFromServer() async {
    final ResponseHandler<BaseResponse<ClientProfileResponse>> response = await _profileRepository.getProfile();
    if (response.isSuccess()) {
      final BaseResponse<ClientProfileResponse>? baseResponse = response.getSuccessInstance()?.response;
      final ClientProfileResponse? profile = baseResponse?.data;
      if (profile != null) {
        if (mounted) {
          setState(() {
            _nameController.text = profile.name;
            _emailController.text = profile.email;
            _phoneController.text = profile.phone ?? '';
            _usernameController.text = profile.username;

            _originalName = profile.name;
            _originalEmail = profile.email;
            _originalPhone = profile.phone ?? '';
            _originalUsername = profile.username;

            _countryDialCode = (profile.countryCode ?? '+91').trim();
            if (!_countryDialCode.startsWith('+') && _countryDialCode.isNotEmpty) {
              _countryDialCode = '+$_countryDialCode';
            }
            _originalCountryDialCode = _countryDialCode;

            try {
              final List<CountryCode> countries = loadLocalizedCountryCodes(context);
              final CountryCode? match = countries.firstWhereOrNull(
                (CountryCode country) => country.dialCode == _countryDialCode,
              );
              if (match != null) {
                _countryIsoCode = match.code ?? 'IN';
              }
            } on Object catch (_) {}
          });
        }
        if (profile.profilePictureUrl != null && profile.profilePictureUrl!.isNotEmpty) {
          try {
            await FastCachedImageConfig.deleteCachedImage(imageUrl: profile.profilePictureUrl!);
            await FastCachedImageProvider(profile.profilePictureUrl!).evict();
            PaintingBinding.instance.imageCache.clear();
            PaintingBinding.instance.imageCache.clearLiveImages();
          } on Exception catch (e) {
            DebugLog.instance.e('Error deleting cached image: $e');
          }
        }

        await UserProfileService.instance().updateUserProfile(
          customerName: profile.name,
          customerEmail: profile.email,
          phoneNumber: profile.phone ?? '',
          username: profile.username,
          customerId: profile.publicId,
          prefix: profile.countryCode,
          profilePictureUrl: profile.profilePictureUrl,
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.removeListener(_onFieldChanged);
    _usernameController.removeListener(_onFieldChanged);
    _emailController.removeListener(_onFieldChanged);
    _phoneController.removeListener(_onFieldChanged);

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

  Future<void> _pickImage(ImageSource source) async {
    final PermissionManager permManager = PermissionManager();
    
    if (source == ImageSource.camera) {
      final bool hasPermission = await permManager.requestCameraPermission();
      if (!hasPermission) {
        if (mounted) {
          context.scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Camera permission denied. Please grant permission in settings.'),
              backgroundColor: AppColors.errorColor,
            ),
          );
        }
        return;
      }
    }

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (file != null) {
        setState(() {
          _selectedImage = file;
        });
      }
    } on Object catch (e) {
      DebugLog.instance.e('Error picking image: $e');
      if (mounted) {
        context.scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: AppColors.errorColor,
          ),
        );
      }
    }
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
                  unawaited(_pickImage(ImageSource.gallery));
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  unawaited(_pickImage(ImageSource.camera));
                },
              ),
            ],
          ),
        );
      },
    ));
  }

  int? _requiredPhoneLength(String dialCode) {
    final String cleanDialCode = dialCode.replaceAll(RegExp(r'[^\d+]'), '').trim();
    switch (cleanDialCode) {
      case '+91':
      case '91':
        return 10;
      case '+965':
      case '965':
        return 8;
      case '+971':
      case '971':
        return 9;
      case '+966':
      case '966':
        return 9;
      case '+1':
      case '1':
        return 10;
      case '+974':
      case '974':
        return 8;
      case '+973':
      case '973':
        return 8;
      case '+968':
      case '968':
        return 8;
      case '+44':
      case '44':
        return 10;
      default:
        return null;
    }
  }

  String? _validatePhoneNumber(String phone, String dialCode) {
    final String trimmedPhone = phone.trim();
    if (trimmedPhone.isEmpty) {
      return 'Please enter phone number';
    }
    if (!RegExp(r'^\d+$').hasMatch(trimmedPhone)) {
      return 'Only numbers are allowed';
    }
    final int? requiredLength = _requiredPhoneLength(dialCode);
    if (requiredLength != null && trimmedPhone.length != requiredLength) {
      return 'Please enter a valid $requiredLength-digit phone number';
    }
    if (requiredLength == null && (trimmedPhone.length < 6 || trimmedPhone.length > 15)) {
      return 'Please enter a valid phone number (6-15 digits)';
    }
    return null;
  }

  Future<void> _updateProfile() async {
    final String? phoneValErr = _validatePhoneNumber(_phoneController.text, _countryDialCode);
    if (phoneValErr != null) {
      setState(() {
        _phoneErrorMsg = phoneValErr;
      });
      return;
    } else {
      setState(() {
        _phoneErrorMsg = '';
      });
    }

    if (_formKey.currentState?.validate() ?? false) {
      final String name = _nameController.text.trim();
      final String username = _usernameController.text.trim();
      final String email = _emailController.text.trim();
      final String phone = _phoneController.text.trim();

      unawaited(EasyLoading.show(status: 'Updating...'));

      try {
        final ResponseHandler<BaseResponse<ClientProfileResponse>> response = await _profileRepository.updateProfile(
          UpdateClientProfileRequest(
            name: name,
            phone: phone,
            countryCode: _countryDialCode,
            profilePicture: _selectedImage,
          ),
        );

        if (response.isSuccess()) {
          final BaseResponse<ClientProfileResponse>? baseResponse = response.getSuccessInstance()?.response;
          final ClientProfileResponse? updated = baseResponse?.data;

          try {
            if (updated != null && _selectedImage != null) {
              final String oldUrl = UserProfileService.instance().profilePictureUrl;
              if (oldUrl.isNotEmpty) {
                try {
                  await FastCachedImageConfig.deleteCachedImage(imageUrl: oldUrl);
                  await FastCachedImageProvider(oldUrl).evict();
                } on Object catch (e) {
                  DebugLog.instance.e('Error deleting cached image: $e');
                }
              }
              if (updated.profilePictureUrl != null && updated.profilePictureUrl!.isNotEmpty) {
                try {
                  await FastCachedImageConfig.deleteCachedImage(imageUrl: updated.profilePictureUrl!);
                  await FastCachedImageProvider(updated.profilePictureUrl!).evict();
                } on Object catch (e) {
                  DebugLog.instance.e('Error deleting cached image: $e');
                }
              }
              try {
                PaintingBinding.instance.imageCache.clear();
                PaintingBinding.instance.imageCache.clearLiveImages();
              } on Object catch (e) {
                DebugLog.instance.e('Error clearing image cache: $e');
              }
            }
          } on Object catch (e) {
            DebugLog.instance.e('Error during image cache operations: $e');
          }

          try {
            await UserProfileService.instance().updateUserProfile(
              customerName: updated?.name ?? name,
              username: updated?.username ?? username,
              customerEmail: updated?.email ?? email,
              phoneNumber: updated?.phone ?? phone,
              prefix: updated?.countryCode ?? UserProfileService.instance().prefix,
              profilePictureUrl: updated?.profilePictureUrl,
            );
          } on Object catch (e) {
            DebugLog.instance.e('Error updating local user profile service: $e');
          }

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
        } else {
          final OnFailureResponse<BaseResponse<ClientProfileResponse>>? failure = response.getFailureInstance();
          if (mounted) {
            context.scaffoldMessenger.showSnackBar(
              SnackBar(
                backgroundColor: AppColors.errorColor,
                content: Text(
                  failure?.error?.errorMessage ?? 'Failed to update profile.',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        }
      } on Object catch (e, stack) {
        DebugLog.instance.e('Error updating profile: $e \n$stack');
        if (mounted) {
          context.scaffoldMessenger.showSnackBar(
            SnackBar(
              backgroundColor: AppColors.errorColor,
              content: Text('An unexpected error occurred: $e'),
            ),
          );
        }
      } finally {
        unawaited(EasyLoading.dismiss());
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
                      ListenableBuilder(
                        listenable: UserProfileService.instance(),
                        builder: (BuildContext context, Widget? child) {
                          final UserProfileService profile = UserProfileService.instance();
                          final String imageUrl = profile.profilePictureUrl;
                          final bool hasImageUrl = imageUrl.isNotEmpty;

                          final String name = profile.customerName.isNotEmpty
                              ? profile.customerName
                              : (profile.username.isNotEmpty ? profile.username : 'Sajid');
                          final String initial = name.isNotEmpty ? name[0].toUpperCase() : 'S';

                          return Stack(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  Uint8List? localBytes;
                                  if (_selectedImage != null) {
                                    localBytes = await _selectedImage!.readAsBytes();
                                  }
                                  if (context.mounted) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => ProfileImagePreviewPage(
                                          name: name,
                                          initial: initial,
                                          imageUrl: imageUrl,
                                          localImageBytes: localBytes,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
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
                                      child: _selectedImage != null
                                          ? FutureBuilder<List<int>>(
                                              future: _selectedImage!.readAsBytes(),
                                              builder: (
                                                BuildContext context,
                                                AsyncSnapshot<List<int>> snapshot,
                                              ) {
                                                if (snapshot.hasData) {
                                                  return Image.memory(
                                                    Uint8List.fromList(snapshot.data!),
                                                    fit: BoxFit.cover,
                                                    width: Dimens.size110,
                                                    height: Dimens.size110,
                                                  );
                                                }
                                                return const Center(
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: AppColors.primaryPurple,
                                                  ),
                                                );
                                              },
                                            )
                                          : hasImageUrl
                                              ? FastCachedImage(
                                                  key: ValueKey<String>(imageUrl),
                                                  url: imageUrl,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (BuildContext context, FastCachedProgressData progress) => const Center(
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: AppColors.primaryPurple,
                                                    ),
                                                  ),
                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace) => Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: AppColors.primaryButtonGradient,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: CustomTextLabelWidget(
                                                      label: initial,
                                                      style: const TextStyle(
                                                        color: AppColors.whiteColor,
                                                        fontWeight: FontWeight.w800,
                                                        fontSize: Dimens.fontSize40,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: AppColors.primaryButtonGradient,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: CustomTextLabelWidget(
                                                    label: initial,
                                                    style: const TextStyle(
                                                      color: AppColors.whiteColor,
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: Dimens.fontSize40,
                                                    ),
                                                  ),
                                                ),
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
                          );
                        },
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
                        readOnly: true,
                        fillColor: inputFieldBg,
                        borderColor: borderCol,
                        style: TextStyle(color: textColor.withOpacity(0.6)),
                        titleStyle: TextStyle(
                          color: subtitleColor,
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w600,
                        ),
                        suffixIcon: Icon(
                          Icons.lock_outline_rounded,
                          size: Dimens.size16,
                          color: subtitleColor.withOpacity(0.5),
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
                        readOnly: true,
                        fillColor: inputFieldBg,
                        borderColor: borderCol,
                        style: TextStyle(color: textColor.withOpacity(0.6)),
                        titleStyle: TextStyle(
                          color: subtitleColor,
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w600,
                        ),
                        suffixIcon: Icon(
                          Icons.lock_outline_rounded,
                          size: Dimens.size16,
                          color: subtitleColor.withOpacity(0.5),
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

                      // Phone Field with Country Picker
                      SignUpPhoneFieldWidget(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        label: context.appString.editProfilePhoneLabelKey,
                        errorMsg: _phoneErrorMsg,
                        countryIsoCode: _countryIsoCode,
                        dialCode: _countryDialCode,
                        onCountryChanged: (CountryCode country) {
                          setState(() {
                            _countryDialCode = (country.dialCode ?? '+91').replaceAll(RegExp(r'[^\d+]'), '').trim();
                            _countryIsoCode = country.code ?? 'IN';
                            if (_phoneController.text.isNotEmpty) {
                              _phoneErrorMsg = _validatePhoneNumber(_phoneController.text, _countryDialCode) ?? '';
                            }
                          });
                        },
                        onChanged: (String val) {
                          setState(() {
                            _phoneErrorMsg = _validatePhoneNumber(val, _countryDialCode) ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: Dimens.space32),

                      // Update Profile Button
                      CustomButtonWidget(
                        title: context.appString.editProfileUpdateBtnKey,
                        onTap: _updateProfile,
                        borderRadius: Dimens.radius10,
                        isButtonEnabled: _hasChanges(),
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
