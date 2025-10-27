import '../../../../utils/exports.dart';

///[GiftCardPageWidget] is used to display the gift card page
///in this widget user can select amount of gift card
///also user can add recipient details and send it.
class GiftCardPageWidget extends StatelessWidget {
  ///
  const GiftCardPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: MainConfig.appColors.mainColor,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              ProductDetailsAppBar(
                titleText: context.appString.giftCardsKey,
                isLastWidgetDisplay: false,
                isShadowDisplay: false,
                titleColors: MainConfig.appColors.backgroundWhite,
                backgroundProductDetails: MainConfig.appColors.mainColor,
                prefixIcon: Assets.svgs.icBack.svg(
                  colorFilter: ColorFilter.mode(
                    MainConfig.appColors.backgroundWhite,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: MainConfig.appColors.mainColor,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Dimens.space26.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space16,
                        ),
                        child: Assets.svgs.bgGf.svg(),
                      ),
                      Dimens.space19.heightBox,
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.space16),
                  child: Column(
                    children: <Widget>[
                      Dimens.space16.heightBox,
                      CustomTextLabelWidget(
                        label: context.appString.selectAmountKey,
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.fontSize18,
                          color: MainConfig.appColors.textBlackColor,
                          height: Dimens.lineHeight22
                              .toLineHeight(Dimens.fontSize18),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: Dimens.space16),
                        child: AmountSelectGiftCard(),
                      ),
                      BlocBuilder<GiftCardCubit, GiftCardState>(
                        buildWhen: (GiftCardState previous, GiftCardState current) {
                          // Only rebuild when custom amount controller changes
                          return previous.customAmountController != current.customAmountController;
                        },
                        builder: (BuildContext context, GiftCardState state) {
                          return CommonTextFormFieldWidget(
                            controller: state.customAmountController,
                            focusNode: state.customAmountFocusNode,
                            label: context.appString.customAmountKey,
                            textInputType: TextInputType.number,
                            onChange: (String value) {
                              //    context.read<GiftCardCubit>().onCustomAmountChanged(value);
                            },
                            input: TextInputAction.next,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              // Allows only digits
                              LengthLimitingTextInputFormatter(
                                  Dimens.size200.toInt()),
                            ],
                          );
                        },
                      ),
                      Dimens.space25.heightBox,
                      BlocBuilder<GiftCardCubit, GiftCardState>(
                        buildWhen: (GiftCardState previous, GiftCardState current) {
                          // This is a static label, no rebuild needed
                          return false;
                        },
                        builder: (BuildContext context, GiftCardState state) {
                          return CustomTextLabelWidget(
                            label: context.appString.chooseRecipientKey,
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: Dimens.fontSize18,
                              color: MainConfig.appColors.textBlackColor,
                              height: Dimens.lineHeight22
                                  .toLineHeight(Dimens.fontSize18),
                            ),
                          );
                        },
                      ),
                      Dimens.space16.heightBox,
                      BlocBuilder<GiftCardCubit, GiftCardState>(
                        buildWhen: (GiftCardState previous, GiftCardState current) {
                          // Only rebuild when recipient name error message changes
                          return previous.recipientFullNameErrorMessage != current.recipientFullNameErrorMessage;
                        },
                        builder: (BuildContext context, GiftCardState state) {
                          return CommonTextFormFieldWidget(
                            maxLength: Dimens.maxLength50,
                            controller: state.recipientFullNameController,
                            errorMsg: state.recipientFullNameErrorMessage,
                            label: context.appString.recipientFullNameKey,
                            focusNode: state.recipientFullNameFocusNode,
                            input: TextInputAction.next,
                            onChange: (String value) {
                              if (value.validateFirstLastNameField() == true) {
                                context
                                    .read<GiftCardCubit>()
                                    .handleValidationRecipientFullNameErrorMessage(
                                        '');
                              }
                            },
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                  Dimens.size200.toInt()),
                            ],
                          );
                        },
                      ),
                      Dimens.space16.heightBox,
                      BlocBuilder<GiftCardCubit, GiftCardState>(
                        buildWhen: (GiftCardState previous, GiftCardState current) {
                          // Only rebuild when recipient email error message changes
                          return previous.recipientEmailErrorMessage != current.recipientEmailErrorMessage;
                        },
                        builder: (BuildContext context, GiftCardState state) {
                          return CommonTextFormFieldWidget(
                            maxLength: Dimens.maxLength50,
                            controller: state.recipientEmailController,
                            errorMsg: state.recipientEmailErrorMessage,
                            focusNode: state.recipientEmailFocusNode,
                            label: context.appString.recipientEmailIdKey,
                            input: TextInputAction.done,
                            onChange: (String value) {
                              if (value.validateEmailBool() ?? false) {
                                context
                                    .read<GiftCardCubit>()
                                    .handleValidationRecipientEmailErrorMessage(
                                        '');
                              }
                            },
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                  Dimens.size200.toInt()),
                            ],
                          );
                        },
                      ),
                      Dimens.space25.heightBox,
                      CustomGradientButtonWidget(
                        title: context.appString.sendKey,
                        titleTextStyle: context.textTheme.headlineMedium
                            ?.copyWith(
                                fontSize: Dimens.fontSize16,
                                color: Colors.white,
                                height: Dimens.lineHeight24
                                    .toLineHeight(Dimens.fontSize16),
                                fontWeight: FontWeight.w700),
                        onTap: () {
                          /*cubit.callEditProfileSaveData(
                          context.size?.width.toString() ?? "");*/
                          if (validateGiftCardForm(context)) {
                            debugPrint("Validate gift card form");
                          }
                        },
                      ),
                      Dimens.space25.heightBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///[validateGiftCardForm] is used to validate the gift card form
  ///[context] is used to get the context of the widget
  ///it contain following validation
  ///1. recipient full name is not empty
  ///2. recipient email is valid
  ///if any of the validation is failed then it will return false otherwise true
  bool validateGiftCardForm(BuildContext context) {
    final GiftCardCubit giftCardCubit = context.instance<GiftCardCubit>();

    final String chooseRecipientName =
        giftCardCubit.state.recipientFullNameController.text.trim();
    final String chooseRecipientEmail =
        giftCardCubit.state.recipientEmailController.text.trim();

    bool isValid = true;

    if (chooseRecipientName.isEmpty) {
      isValid = false;
      giftCardCubit.handleValidationRecipientFullNameErrorMessage(
          context.appString.pleaseEnterTheFullNameKey);
    }


      final String? emailError = chooseRecipientEmail.validateEmail
        (isOnlyEmail: true,
          enterMobileOrNumberMsg: context.appString.pleaseEnterMobileOrNumberKey,
          enterEmailMsg: context.appString.pleaseEnterTheEmailIdKey,
          validEmailMsg:context.appString.pleaseEnterTheValidEmailIdKey );
      if (emailError?.isNotEmpty ?? false) {
        isValid = false;
        giftCardCubit
            .handleValidationRecipientEmailErrorMessage(emailError ?? "");
      } else {
        giftCardCubit.handleValidationRecipientEmailErrorMessage("");
      }


    return isValid;
  }
}
