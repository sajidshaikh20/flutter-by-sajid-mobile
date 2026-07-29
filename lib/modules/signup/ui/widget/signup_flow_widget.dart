import 'package:step_progress/step_progress.dart';

import '../../../../utils/exports.dart';

/// Sign up shell: fixed header, step progress, scrollable step body, sticky footer.
class SignUpFlowWidget extends StatefulWidget {
  /// Creates [SignUpFlowWidget].
  const SignUpFlowWidget({super.key});

  @override
  State<SignUpFlowWidget> createState() => _SignUpFlowWidgetState();
}

class _SignUpFlowWidgetState extends State<SignUpFlowWidget> {

  void _syncStep(BuildContext context, int step) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    if (cubit.state.currentStep == step) {
      return;
    }
    cubit.setStep(step);
  }

  Future<void> _handleNext(BuildContext context, SignUpCubit cubit, SignUpState state) async {
    if (cubit.isLastStep) {
      await cubit.registerUser(context);
      return;
    }

    if (!cubit.tryProceedFromCurrentStep(context)) {
      return;
    }

    final int nextStep = state.currentStep + 1;
    _syncStep(context, nextStep);
  }

  List<String> _stepTitles(BuildContext context, int totalSteps, UserRole accountType) {
    if (accountType == UserRole.client) {
      return <String>[
        'Basic Info',
        'Verification',
        'Profile Setup',
      ];
    } else {
      return <String>[
        'Basic Info',
        'Verification',
        'Profile Setup',
        'Trader Profile',
        'Strategy & Risk',
        'Documents & Sign',
      ];
    }
  }

  Widget _buildStepForm(int step, SignUpState state) {
    switch (step) {
      case 0:
        return const SignUpBasicInfoForm();
      case 1:
        return SignUpVerificationForm(email: state.email);
      case 2:
        return const SignUpCompleteProfileForm();
      case 3:
        return const SignUpTraderProfileForm();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;

    return NoInternetWidget(
      onTryAgain: () {},
      childWidget: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (BuildContext context, SignUpState state) {
          final SignUpCubit cubit = context.read<SignUpCubit>();

          return Scaffold(
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: true,
            appBar: GradientAppBarWidget(
              title: context.appString.signUpTitleKey,
              onBackPressed: () => goBack(context),
            ),
            bottomNavigationBar: _SignUpStickyBottomBar(
              canGoPrevious: cubit.canGoPrevious,
              isLastStep: cubit.isLastStep,
              isNextEnabled: cubit.isNextEnabled(),
              backgroundColor: backgroundColor,
              onPrevious: () {
                if (cubit.canGoPrevious) {
                  _syncStep(context, state.currentStep - 1);
                }
              },
              onNext: () => _handleNext(context, cubit, state),
            ),
            body: Form(
              key: state.formKey,
              child: BlocListener<SignUpCubit, SignUpState>(
                listenWhen: (SignUpState p, SignUpState c) =>
                    p.currentStep != c.currentStep ||
                    p.isEmailVerified != c.isEmailVerified ||
                    p.isPhoneVerified != c.isPhoneVerified ||
                    p.status != c.status ||
                    p.msg != c.msg,
                listener: (BuildContext context, SignUpState state) {
                  if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
                    displaySnackBar(state.msg!, context);
                    cubit.clearMsg();
                  }
                  if (state.status == BaseStateStatus.success && cubit.isLastStep) {
                    unawaited(context.router.replaceAll(<PageRouteInfo>[const SocialLoginRoute()]));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Dimens.size8,
                        Dimens.size8,
                        Dimens.size8,
                        Dimens.size16,
                      ),
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          final double minRequiredWidth = state.totalSteps * 1.45 * Dimens.size40;
                          final Widget stepProgress = StepProgress(
                            totalSteps: state.totalSteps,
                            currentStep: state.currentStep,
                            stepNodeSize: Dimens.size40,
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimens.size4,
                            ),
                            theme: buildSignUpStepProgressTheme(context),
                            nodeIconBuilder: (int index, int currentStep) {
                              return SignUpStepNodeCircle(
                                stepNumber: index + 1,
                                state: signUpStepNodeState(
                                  index: index,
                                  currentStep: currentStep,
                                ),
                                isDark: isDark,
                              );
                            },
                            nodeLabelBuilder: (int index, int currentStep) {
                              if (state.totalSteps > 3) {
                                return null;
                              }
                              return buildSignUpStepLabel(
                                context,
                                index: index,
                                currentStep: currentStep,
                                titles: _stepTitles(context, state.totalSteps, state.accountType),
                              );
                            },
                            onStepNodeTapped: (int index) {
                              if (index <= state.currentStep) {
                                _syncStep(context, index);
                              }
                            },
                            onStepChanged: (int index) {
                              _syncStep(context, index);
                            },
                          );

                          if (minRequiredWidth > constraints.maxWidth) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: stepProgress,
                            );
                          }
                          return stepProgress;
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildStepForm(state.currentStep, state),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Previous / Next pinned at the bottom.
class _SignUpStickyBottomBar extends StatelessWidget {
  const _SignUpStickyBottomBar({
    required this.canGoPrevious,
    required this.isLastStep,
    required this.isNextEnabled,
    required this.backgroundColor,
    required this.onPrevious,
    required this.onNext,
  });

  final bool canGoPrevious;
  final bool isLastStep;
  final bool isNextEnabled;
  final Color backgroundColor;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color borderColor = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: borderColor)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryPurple.withValues(
              alpha: isDark ? 0.12 : 0.08,
            ),
            blurRadius: Dimens.blurRadius10,
            offset: const Offset(0, -Dimens.offset2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.size16,
            Dimens.size12,
            Dimens.size16,
            Dimens.size8,
          ),
          child: Row(
            children: <Widget>[
              if (canGoPrevious)
                Expanded(
                  child: CustomButtonWidget(
                    title: context.appString.signUpPreviousKey,
                    isPrimaryButton: false,
                    onTap: onPrevious,
                  ),
                ),
              if (canGoPrevious) Dimens.size12.widthBox,
              Expanded(
                child: CustomButtonWidget(
                  title: isLastStep
                      ? context.appString.signUpFinishKey
                      : context.appString.signUpNextKey,
                  isButtonEnabled: isNextEnabled,
                  onTap: onNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
