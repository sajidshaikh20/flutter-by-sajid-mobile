import '../../../../utils/exports.dart';

/// A tappable row to enter delivery instructions, styled like the discount box.
class DeliveryInstructionWidget extends StatelessWidget {

  /// DeliveryInstructionWidget
  const DeliveryInstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: MainConfig.appColors.lightGreyColor,
          width: Dimens.borderWidth05,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.space8)),
        color: MainConfig.appColors.backgroundWhite,
      ),
      child: InkWell(
        onTap: () async {
          final TextEditingController controller = TextEditingController(
            text: context.read<CartPageCubit>().state.deliveryInstructions ?? '',
          );
          await showCustomBottomSheetView(
            context: context,
            title: context.appString.addDeliveryInstructionKey,
            bothExtremeEnd: true,
            backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
            child: StatefulBuilder(
              builder: (BuildContext ctx, void Function(void Function()) setState) {
                final FocusNode focusNode = FocusNode();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!focusNode.hasFocus) {
                    FocusScope.of(ctx).requestFocus(focusNode);
                  }
                });
                return SizedBox(
                  height: ctx.height * 0.80,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.space16,
                      right: Dimens.space16,
                      top: Dimens.space30,
                      bottom: Dimens.space9,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: Dimens.size150,
                          child: CustomTextFormFieldWidget(
                            controller: controller,
                            focusNode: focusNode,
                            autoFocus: true,
                            maxLength: 100,
                            minLines: 4,
                            maxLines: Dimens.maxLines10,
                            onChange: (_) => setState(() {}),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MainConfig.appColors.dukkanborderGreyLightColor,
                                  width: Dimens.borderWidth05,
                                ),
                                borderRadius: Dimens.radius8.borderRadius,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MainConfig.appColors.dukkanborderGreyLightColor,
                                  width: Dimens.borderWidth05,
                                ),
                                borderRadius: Dimens.radius8.borderRadius,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MainConfig.appColors.dukkanborderGreyLightColor,
                                  width: Dimens.borderWidth05,
                                ),
                                borderRadius: Dimens.radius8.borderRadius,
                              ),
                              filled: true,
                              fillColor: AppColors.whiteColor,
                              counterText: '',
                              isCollapsed: false,
                              hintStyle: context.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: MainConfig.appColors.labelGrey,
                                  fontSize: Dimens.fontSize16),
                              hintText: context.appString.writeDeliveryInstructionKey,
                              contentPadding: const EdgeInsets.only(
                                top: Dimens.space30,
                                bottom: Dimens.space9,
                                left: Dimens.space12,
                                right: Dimens.space12,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextLabelWidget(
                            textDirection: TextDirection.ltr,
                            label: '${controller.text.length.toString().padLeft(2, AppConstant.zeroStr)}/100',
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: MainConfig.appColors.labelGrey,
                              fontSize: Dimens.fontSize12,
                              height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                            ),
                          ),
                        ),
                        Dimens.space24.heightBox,
                        Row(
                          children: <Widget>[
                            const Spacer(),
                            CustomTextLabelWidget(
                              label: context.appString.clearKey,
                              onTap: () {
                                controller.clear();
                                setState(() {});
                              },
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: MainConfig.appColors.mainColor,
                                fontSize: Dimens.fontSize14,
                                height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: Dimens.size160,
                              child: CustomGradientButtonWidget(
                                title: context.appString.saveKey,
                                isButtonEnabled: controller.text.trim().isNotEmpty,
                                onTap: () async {
                                  context.read<CartPageCubit>().setDeliveryInstructions(controller.text);
                                  context.router.popForced();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space12,
            vertical: Dimens.space12,
          ),
          child: Row(
            children: <Widget>[
              Assets.svgs.icDeliveryInstruction.svg(),
              const SizedBox(width: Dimens.size10),
              Expanded(
                child: CustomTextLabelWidget(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  label: context.appString.deliveryInstructionKey,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: MainConfig.appColors.labelGrey,
                    fontSize: Dimens.fontSize14,
                    height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  ),
                ),
              ),
              const SizedBox(width: Dimens.size12),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final TextEditingController controller = TextEditingController(
                    text: context.read<CartPageCubit>().state.deliveryInstructions ?? '',
                  );
                  await showCustomBottomSheetView(
                    context: context,
                    title: context.appString.addDeliveryInstructionKey,
                    bothExtremeEnd: true,
                    backgroundColor: MainConfig.appColors.backgroundPinkColor,
                    child: StatefulBuilder(
                      builder: (BuildContext ctx, void Function(void Function()) setState) {
                        final FocusNode focusNode = FocusNode();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!focusNode.hasFocus) {
                            FocusScope.of(ctx).requestFocus(focusNode);
                          }
                        });
                        return SizedBox(
                          height: ctx.height * 0.75,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.space16,
                              right: Dimens.space16,
                              top: Dimens.space30,
                              bottom: Dimens.space9,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: Dimens.size150,
                                  child: CustomTextFormFieldWidget(
                                    controller: controller,
                                    focusNode: focusNode,
                                    autoFocus: true,
                                    maxLength: 100,
                                    maxLines: Dimens.maxLines10,
                                    onChange: (_) => setState(() {}),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MainConfig.appColors.lightGreyColor,
                                          width: Dimens.borderWidth05,
                                        ),
                                        borderRadius: Dimens.radius8.borderRadius,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MainConfig.appColors.lightGreyColor,
                                          width: Dimens.borderWidth05,
                                        ),
                                        borderRadius: Dimens.radius8.borderRadius,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MainConfig.appColors.lightGreyColor,
                                          width: Dimens.borderWidth05,
                                        ),
                                        borderRadius: Dimens.radius8.borderRadius,
                                      ),
                                      filled: true,
                                      fillColor: AppColors.whiteColor,
                                      counterText: '',
                                      isCollapsed: false,
                                      contentPadding: const EdgeInsets.only(
                                        top: Dimens.space30,
                                        bottom: Dimens.space9,
                                        left: Dimens.space12,
                                        right: Dimens.space12,
                                      ),
                                      hintText: context.appString.writeDeliveryInstructionKey,
                                      hintStyle: context.textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomTextLabelWidget(
                                    textDirection: TextDirection.ltr,
                                    label: '${controller.text.length.toString().padLeft(2, '0')}/100',
                                    style: context.textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: MainConfig.appColors.labelGrey,
                                      fontSize: Dimens.fontSize12,
                                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                                    ),
                                  ),
                                ),
                                Dimens.space24.heightBox,
                                Row(
                                  children: <Widget>[
                                    const Spacer(),
                                    CustomTextLabelWidget(
                                      label: context.appString.clearKey,
                                      onTap: () {
                                        controller.clear();
                                        setState(() {});
                                      },
                                      style: context.textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: MainConfig.appColors.mainColor,
                                        fontSize: Dimens.fontSize14,
                                        height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: Dimens.size160,
                                      child: CustomGradientButtonWidget(
                                        title: context.appString.saveKey,
                                        isButtonEnabled: controller.text.trim().isNotEmpty,
                                        onTap: () async {
                                          context.read<CartPageCubit>().setDeliveryInstructions(controller.text);
                                          context.router.popForced();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical : Dimens.space8),
                  child: Assets.svgs.icArrowNextBlack.svg(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


