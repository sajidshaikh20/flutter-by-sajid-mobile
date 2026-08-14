import '../../../../utils/exports.dart';

Future<void> showChangePasswordModal(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) => const ChangePasswordModal(),
  );
}

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _currentFocusNode = FocusNode();
  final FocusNode _newFocusNode = FocusNode();
  final FocusNode _confirmFocusNode = FocusNode();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  String _currentError = '';
  String _newError = '';
  String _confirmError = '';
  String? _apiError;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentFocusNode.dispose();
    _newFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitChangePassword() async {
    setState(() {
      _apiError = null;
      _currentError = '';
      _newError = '';
      _confirmError = '';
    });

    final String currentPass = _currentPasswordController.text.trim();
    final String newPass = _newPasswordController.text.trim();
    final String confirmPass = _confirmPasswordController.text.trim();

    bool isValid = true;

    if (currentPass.isEmpty) {
      _currentError = 'Please enter your current password';
      isValid = false;
    }

    if (newPass.isEmpty) {
      _newError = 'Please enter a new password';
      isValid = false;
    } else if (newPass.length < 6) {
      _newError = 'Password must be at least 6 characters';
      isValid = false;
    }

    if (confirmPass.isEmpty) {
      _confirmError = 'Please confirm your new password';
      isValid = false;
    } else if (confirmPass != newPass) {
      _confirmError = 'Passwords do not match';
      isValid = false;
    }

    if (!isValid) {
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final ResponseHandler<BaseResponse<dynamic>> response =
        await ProfileRepositoryImpl().changePassword(
      currentPassword: currentPass,
      newPassword: newPass,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (response.isSuccess()) {
      final BaseResponse<dynamic>? baseResponse = response.getSuccessInstance()?.response;
      if (baseResponse != null && baseResponse.success) {
        Navigator.pop(context);
        displaySnackBar(
          baseResponse.message.isNotEmpty ? baseResponse.message : 'Password changed successfully',
          context,
        );
      } else {
        setState(() {
          _apiError = baseResponse?.message ?? 'Failed to change password.';
        });
      }
    } else {
      final String error =
          response.getFailureInstance()?.error?.errorMessage ?? 'Failed to change password.';
      setState(() {
        _apiError = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color cardBackground = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Dimens.radius24),
          ),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: subtitleColor.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.space16),

                // Title row
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(Dimens.space10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        color: AppColors.primaryPurple,
                        size: Dimens.size24,
                      ),
                    ),
                    const SizedBox(width: Dimens.space12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: 'Change Password',
                            style: TextStyle(
                              color: textColor,
                              fontSize: Dimens.fontSize18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          CustomTextLabelWidget(
                            label: 'Enter your current password and a new password',
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: Dimens.fontSize12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close_rounded, color: subtitleColor, size: Dimens.size20),
                    ),
                  ],
                ),

                const SizedBox(height: Dimens.space20),

                if (_apiError != null) ...<Widget>[
                  Container(
                    padding: const EdgeInsets.all(Dimens.space12),
                    decoration: BoxDecoration(
                      color: AppColors.errorColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Dimens.radius12),
                      border: Border.all(
                        color: AppColors.errorColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.error_outline_rounded, color: AppColors.errorColor, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextLabelWidget(
                            label: _apiError!,
                            style: const TextStyle(
                              color: AppColors.errorColor,
                              fontSize: Dimens.fontSize12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.space16),
                ],

                // Current Password Field
                CommonTextFormFieldWidget(
                  controller: _currentPasswordController,
                  label: 'Current Password',
                  input: TextInputAction.next,
                  focusNode: _currentFocusNode,
                  errorMsg: _currentError,
                  maxLength: Dimens.maxLength50,
                  obscureText: _obscureCurrent,
                  onChange: (String val) {
                    if (val.isNotEmpty && _currentError.isNotEmpty) {
                      setState(() => _currentError = '');
                    }
                  },
                  onTextSubmit: (_) {
                    FocusScope.of(context).requestFocus(_newFocusNode);
                  },
                  suffixIcon: CustomTextLabelWidget(
                    label: _obscureCurrent ? context.appString.showKey : context.appString.hideKey,
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      fontSize: Dimens.fontSize12,
                    ),
                    onTap: () {
                      setState(() => _obscureCurrent = !_obscureCurrent);
                    },
                  ),
                ),

                const SizedBox(height: Dimens.space16),

                // New Password Field
                CommonTextFormFieldWidget(
                  controller: _newPasswordController,
                  label: 'New Password',
                  input: TextInputAction.next,
                  focusNode: _newFocusNode,
                  errorMsg: _newError,
                  maxLength: Dimens.maxLength50,
                  obscureText: _obscureNew,
                  onChange: (String val) {
                    if (val.isNotEmpty && _newError.isNotEmpty) {
                      setState(() => _newError = '');
                    }
                  },
                  onTextSubmit: (_) {
                    FocusScope.of(context).requestFocus(_confirmFocusNode);
                  },
                  suffixIcon: CustomTextLabelWidget(
                    label: _obscureNew ? context.appString.showKey : context.appString.hideKey,
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      fontSize: Dimens.fontSize12,
                    ),
                    onTap: () {
                      setState(() => _obscureNew = !_obscureNew);
                    },
                  ),
                ),

                const SizedBox(height: Dimens.space16),

                // Confirm New Password Field
                CommonTextFormFieldWidget(
                  controller: _confirmPasswordController,
                  label: 'Confirm New Password',
                  input: TextInputAction.done,
                  focusNode: _confirmFocusNode,
                  errorMsg: _confirmError,
                  maxLength: Dimens.maxLength50,
                  obscureText: _obscureConfirm,
                  onChange: (String val) {
                    if (val.isNotEmpty && _confirmError.isNotEmpty) {
                      setState(() => _confirmError = '');
                    }
                  },
                  suffixIcon: CustomTextLabelWidget(
                    label: _obscureConfirm ? context.appString.showKey : context.appString.hideKey,
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      fontSize: Dimens.fontSize12,
                    ),
                    onTap: () {
                      setState(() => _obscureConfirm = !_obscureConfirm);
                    },
                  ),
                ),

                const SizedBox(height: Dimens.space24),

                // Submit Button matching Login styling
                CustomButtonWidget(
                  title: 'Save Password',
                  height: Dimens.size52,
                  borderRadius: Dimens.radius12,
                  titleTextStyle: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize14,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    if (!_isLoading) {
                      await _submitChangePassword();
                    }
                  },
                ),
                const SizedBox(height: Dimens.space12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
