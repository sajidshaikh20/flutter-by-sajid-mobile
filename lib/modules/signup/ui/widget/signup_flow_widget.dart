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
  late final StepProgressController _stepProgressController;

  @override
  void initState() {
    super.initState();
    _stepProgressController = StepProgressController(
      totalSteps: signUpTotalSteps,
      initialStep: 0,
    );
  }

  void _syncStep(BuildContext context, int step) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    if (cubit.state.currentStep == step) {
      return;
    }
    cubit.setStep(step);
    _stepProgressController.setCurrentStep(step);
    AutoTabsRouter.of(context).setActiveIndex(step);
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

  List<String> _stepTitles(BuildContext context) => <String>[
    context.appString.signUpBasicInfoKey,
    context.appString.signUpVerificationKey,
    context.appString.signUpCompleteProfileKey,
  ];

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
              child: AutoTabsRouter(
                routes: <PageRouteInfo<dynamic>>[
                  const SignUpBasicInfoRoute(),
                  SignUpVerificationRoute(email: state.email),
                  const SignUpCompleteProfileRoute(),
                ],
                builder: (BuildContext context, Widget child) {
                  final TabsRouter tabsRouter = AutoTabsRouter.of(context);

                  return BlocListener<SignUpCubit, SignUpState>(
                    listenWhen: (SignUpState p, SignUpState c) =>
                        p.currentStep != c.currentStep ||
                        p.isEmailVerified != c.isEmailVerified ||
                        p.isPhoneVerified != c.isPhoneVerified ||
                        p.status != c.status ||
                        p.msg != c.msg,
                    listener: (BuildContext context, SignUpState state) {
                      if (tabsRouter.activeIndex != state.currentStep) {
                        tabsRouter.setActiveIndex(state.currentStep);
                      }
                      if (_stepProgressController.currentStep !=
                          state.currentStep) {
                        _stepProgressController.setCurrentStep(
                          state.currentStep,
                        );
                      }
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
                          child: StepProgress(
                            controller: _stepProgressController,
                            totalSteps: signUpTotalSteps,
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
                              return buildSignUpStepLabel(
                                context,
                                index: index,
                                currentStep: currentStep,
                                titles: _stepTitles(context),
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
                          ),
                        ),
                        Expanded(child: child),
                      ],
                    ),
                  );
                },
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
