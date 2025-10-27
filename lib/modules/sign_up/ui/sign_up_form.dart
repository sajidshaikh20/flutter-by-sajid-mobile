import '../../../utils/exports.dart';

/// Widget that displays the sign up form with all input fields.
class SignUpForm extends StatelessWidget {
  /// Creates a sign up form widget.
  const SignUpForm({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return _buildSignUpForm(context);
  }

  Widget _buildSignUpForm(BuildContext context) {
    double horizontalPadding = Dimens.space16;
    switch (device) {
      case ScreenType.tablet:
        horizontalPadding = Dimens.space90;

      default:
        break;
    }

    final SignupCubit signUpCubit = context.instance<SignupCubit>();

    return BlocListener<SignupCubit, SignupState>(
      listener: (BuildContext context, SignupState state) async {
        if (state.redirectRoute != null) {
          displaySnackBar(state.successMsg, context);
          //Perform redirection
          final StackRouter router = context.router;
          await Future<void>.delayed(const Duration(
              seconds: Dimens.duration2)); // Add a delay for success message
          await router.push(state.redirectRoute!);
        } else if (state.msg?.isNotEmpty ?? false) {
          // Show error message
          displaySnackBar(state.msg ?? '', context);
        } else if (state.showDefaultErrMsg ?? false) {
          displaySnackBar(
              MainConfig.dynamicString(JsonServiceString.keySomethingWentWrong),
              context);
        }
      },
      listenWhen: (SignupState previous, SignupState current) {
        // Only listen when there's a meaningful state change that should show a snackbar
        return (current.redirectRoute != null && previous.redirectRoute == null) ||
               (current.msg != previous.msg && (current.msg?.isNotEmpty ?? false)) ||
               (current.showDefaultErrMsg ?? false);
      },
      child: NoInternetWidget(
        childWidget: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar(
              title: context.appString.signUpKey,
              device: device,
              endTextStyle: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: MainConfig.appColors.mainColor,
                fontSize: Dimens.fontSize16,
                height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize16),
              ),
              onEndButtonClick: () {
                context.router.removeLast();
              },
              onTap: () {
                context.router.removeLast();
              }),
          body: Stack(
            children: <Widget>[
              // Background SVG
              Positioned.fill(
                child: Assets.svgs.bgFullscreenCommon.svg(
                  fit: BoxFit.fill,),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Form(
                    key: signUpCubit.state.formKey,
                    child: Column(
                      children: <Widget>[
                        Dimens.size16.heightBox,
                        ..._buildFormFields(context),
                        AgreementWidget(
                          device: device,
                        ),
                        Dimens.size12.heightBox,
                        Padding(
                          padding: const EdgeInsets.only(bottom: Dimens.size33),
                          child: SignUpButtonWidget(
                            device: device,
                          ),
                        ),
          
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields(BuildContext context) {
    double heightMobTab14_24 = Dimens.size16;
    switch (device) {
      case ScreenType.tablet:
        heightMobTab14_24 = Dimens.size24;

      default:
        break;
    }
    return <Widget>[
      FirstNameWidget(
        device: device,
      ),
      heightMobTab14_24.heightBox,
      MobileInputWidget(
        device: device,
      ),
      heightMobTab14_24.heightBox,
      EmailWidget(
        device: device,
      ),
      heightMobTab14_24.heightBox,
      NationalityWidget(
        device: device,
      ),
      heightMobTab14_24.heightBox,
      const DateOfBirthFieldWidget(),
      Dimens.size25.heightBox,
      BlocBuilder<SignupCubit, SignupState>(
        buildWhen: (SignupState previous, SignupState current) {
          // Only rebuild when gender error message or selected gender changes
          return previous.genderErrorMessage != current.genderErrorMessage ||
                 previous.selectedGender != current.selectedGender;
        },
        builder: (BuildContext context, SignupState state) {
          return GenderSelection(
            onChanged: (String? gender) {
              if (gender?.isNotEmpty ?? false) {
                context.read<SignupCubit>().updateSelectedGender(gender);
                context
                    .read<SignupCubit>()
                    .handleValidationErrorMessageForGender('');
              }
            },
            initialValue: "",
            errorMessage: state.genderErrorMessage, // Show error from Cubit
          );
        },
      ),
      Dimens.size19.heightBox,
      ReferralCodeWidget(
        device: device,
      ),
      heightMobTab14_24.heightBox,
      PasswordWidget(
        device: device,
      ),
      heightMobTab14_24.heightBox,
    ];
  }
}
