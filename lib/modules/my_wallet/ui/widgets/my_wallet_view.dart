import '../../../../utils/exports.dart';

/// A widget that represents the My Wallet view, showing wallet details and transactions.
class MyWalletView extends StatelessWidget {
  /// A widget that represents the My Wallet view, showing wallet details and transactions.

  const MyWalletView({super.key, this.device = ScreenType.mobile});

  /// The type of device (mobile, tablet, etc.) used for UI adjustments.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    bool isEnglish=context.isEnglishLanguage;
   return Scaffold(
     backgroundColor: MainConfig.appColors.backgroundLightPinkColor,


     body: BlocBuilder<MyWalletCubit, MyWalletState>(
       builder: (BuildContext context, MyWalletState state) => Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           WalletHeaderWidget(
             device: device,
             // Passes the device type for responsive design
             walletAmount:
             state.walletAmount ?? '', // Displays the wallet amount
           ),
           Padding(
             padding: const EdgeInsets.only(left: Dimens.space16,right: Dimens.space16,top: Dimens.space16,bottom: Dimens.space9),
             child: CustomTextLabelWidget(
               textAlign: TextAlign.start,
               maxLines: Dimens.maxLines01,
               overflow: TextOverflow.ellipsis,
               label: context.appString.transactionHistoryKey,
               style: context.textTheme.bodyMedium?.copyWith(
                 color:  MainConfig.appColors.textBlackColor,
                 fontWeight: FontWeight.w700,
                 height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                 fontSize: Dimens.fontSize16,
               ),
             ),
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
               child: state.status==BaseStateStatus.success?
               CustomListView(

                   isPadding: true,
                   itemBuilder: (BuildContext p0, int position) {
                     return Container(
                       margin: const EdgeInsets.only(bottom: Dimens.space8),
                       padding:  EdgeInsets.only(
                           right: isEnglish ?  Dimens.space8 :Dimens.space0,
                           top: Dimens.space8,
                           bottom:  Dimens.space8,
                           left: isEnglish ?  Dimens.space0 :Dimens.space8
                       ),
                       decoration: BoxDecorationExtension.customDecoration(
                         color: AppColors.whiteColor,
                         borderRadius: Dimens.radius8.borderRadius,
                         border: Border.all(
                             color: MainConfig.appColors.lightGreyColor, width: Dimens.borderWidth05),
                       ),
                       child: Row(children: <Widget>[

                         Container(
                           width: Dimens.size2,
                           height: Dimens.size20,
                           decoration: BoxDecoration(
                             color: position%2==0 ? MainConfig.appColors.greenColor : MainConfig.appColors.redColor,
                             borderRadius: isEnglish ? BorderRadius.only(
                               topRight: Dimens.radius8.circularRadius ,  // Top-right corner radius
                               bottomRight: Dimens.radius8.circularRadius, // Bottom-right corner radius
                             ):BorderRadius.only(
                               topLeft: Dimens.radius8.circularRadius ,  // Top-right corner radius
                               bottomLeft: Dimens.radius8.circularRadius, // Bottom-right corner radius
                             ),
                           ),
                         ),
                         const SizedBox(width: Dimens.size6,),
                         Expanded(
                           child: Column(
                             children: <Widget>[

                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[

                                   CustomTextLabelWidget(
                                     maxLines: Dimens.maxLines01,
                                     overflow: TextOverflow.ellipsis,
                                     label:position%2==0? context.appString.refundReceivedKey: context.appString.amountUsedKey,
                                     style: context.textTheme.bodyMedium?.copyWith(
                                       color:  MainConfig.appColors.textBlackColor,
                                       fontWeight: FontWeight.w600,
                                       height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                                       fontSize: Dimens.fontSize14,
                                     ),
                                   ),
                                   CustomTextLabelWidget(
                                     textDirection: TextDirection.ltr,
                                     maxLines: Dimens.maxLines01,
                                     overflow: TextOverflow.ellipsis,
                                     label:position%2==0 ? AppConstant.refundReceived :AppConstant.amountUsed,
                                     style: context.textTheme.bodyMedium?.copyWith(
                                       color:  position%2==0 ? MainConfig.appColors.greenColor : MainConfig.appColors.redColor,
                                       fontWeight: FontWeight.w700,
                                       height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                                       fontSize: Dimens.fontSize14,
                                     ),
                                   )
                                 ],
                               ),
                               const SizedBox(height: Dimens.size2,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   CustomTextLabelWidget(
                                     maxLines: Dimens.maxLines01,
                                     overflow: TextOverflow.ellipsis,
                                     label:  AppConstant.orderId,
                                     style: context.textTheme.bodyMedium?.copyWith(
                                       color:  MainConfig.appColors.creyColor,
                                       fontWeight: FontWeight.normal,
                                       height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                                       fontSize: Dimens.fontSize12,
                                     ),
                                   ),
                                   CustomTextLabelWidget(
                                     textDirection: TextDirection.ltr,
                                     maxLines: Dimens.maxLines01,
                                     overflow: TextOverflow.ellipsis,
                                     label: AppConstant.orderDate,
                                     style: context.textTheme.bodyMedium?.copyWith(
                                       color:  MainConfig.appColors.creyColor,
                                       fontWeight: FontWeight.normal,
                                       height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                                       fontSize: Dimens.fontSize12,
                                     ),
                                   )
                                 ],
                               ),
                             ],
                           ),
                         )
                       ],),
                     );
                   }, itemCount: 12): const TrasactionListShimmer(),
             ),
           )



         ],
       ),
     ),
   );
  }
}
