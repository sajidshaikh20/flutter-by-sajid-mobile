import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';
import 'widget/signup_state_helper.dart';

/// Widget that displays the sign up form with all input fields.
class SignUpForm extends ConsumerWidget {
  /// Creates a sign up form widget.
  const SignUpForm({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();

    // Listen to state changes
    ref.listen<SignupState>(
      signupNotifierProvider(initialState),
      (SignupState? previous, SignupState next) async {
        if (next.redirectRoute != null) {
          displaySnackBar(next.successMsg, context);
          //Perform redirection
          final StackRouter router = context.router;
          await Future<void>.delayed(const Duration(
              seconds: Dimens.duration2)); // Add a delay for success message
          await router.push(next.redirectRoute!);
        } else if (next.msg?.isNotEmpty ?? false) {
          // Show error message
          displaySnackBar(next.msg ?? '', context);
        } else if (next.showDefaultErrMsg ?? false) {
          displaySnackBar(
              "Something Went Wrong",
              context);
        }
      },
    );

    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier signUpNotifier = ref.read(signupNotifierProvider(initialState).notifier);

    double horizontalPadding = Dimens.space16;
    switch (device) {
      case ScreenType.tablet:
        horizontalPadding = Dimens.space90;

      default:
        break;
    }

    return _buildSignUpForm(context, ref, state, signUpNotifier, horizontalPadding);
  }

  Widget _buildSignUpForm(BuildContext context, WidgetRef ref, SignupState state, SignupNotifier signUpNotifier, double horizontalPadding) {
    return NoInternetWidget(
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
                  key: state.formKey,
                    child: Column(
                      children: <Widget>[
                        Dimens.size16.heightBox,
                        ..._buildFormFields(context, ref),
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
      );
  }

  List<Widget> _buildFormFields(BuildContext context, WidgetRef ref) {
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
      Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final SignupState initialState = SignupStateHelper.createInitialState();
          final SignupState state = ref.watch(signupNotifierProvider(initialState));
          final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
          
          return GenderSelection(
            onChanged: (String? gender) {
              if (gender?.isNotEmpty ?? false) {
                notifier.setSelectedGender(gender);
                notifier.handleValidationErrorMessageForGender('');
              }
            },
            initialValue: "",
            errorMessage: state.genderErrorMessage, // Show error from Notifier
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
