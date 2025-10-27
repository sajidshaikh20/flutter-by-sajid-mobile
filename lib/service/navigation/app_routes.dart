import '../../utils/exports.dart';

@AutoRouterConfig()
///AppRouter
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        /// routes go here
        CustomRoute<dynamic>(
            page: ForceUpdateUnderMaintenanceRoute.page,
            path: AppPaths.maintenance,
            opaque: false,
            durationInMilliseconds: 0),
        CustomRoute<dynamic>(
            page: SplashRoute.page,
            path: AppPaths.splash,
            opaque: false,
            initial: true,
            guards: <AutoRouteGuard>[MaintenanceMiddleware()],
            reverseDurationInMilliseconds: 0,
            transitionsBuilder: TransitionsBuilders.noTransition,
            durationInMilliseconds: 0),
        CustomRoute<dynamic>(
          page: SocialLoginRoute.page,
          path: AppPaths.socialLogin,
          opaque: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: LoginRoute.page,
          maintainState: false,
          path: AppPaths.login,
          guards: <AutoRouteGuard>[AuthenticationMiddleWare()],
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ForgotPasswordRoute.page,
          maintainState: false,
          path: AppPaths.forgotPassword,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
            durationInMilliseconds: Dimens.milliseconds400,
            reverseDurationInMilliseconds: Dimens.milliseconds400,
            transitionsBuilder: fadePageTransition,
            page: VerifyOtpRoute.page, path: AppPaths.verifyOtp),

        CustomRoute<dynamic>(
          page: LanguageSelectionRoute.page,
          maintainState: false,
          path: AppPaths.languageSelection,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ChangeLanguageRoute.page,
          maintainState: false,
          path: AppPaths.changeLanguage,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ResetPasswordRoute.page,
          maintainState: false,
          path: AppPaths.resetPassword,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ChangePasswordRoute.page,
          maintainState: false,
          path: AppPaths.changedPassword,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

        CustomRoute<dynamic>(
          page: SignUpRoute.page,
          path: AppPaths.signup,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: DashboardRoute.page,
          path: AppPaths.dashboard,
          guards: <AutoRouteGuard>[StoreSelectionMiddleWare()],
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
          children: <AutoRoute>[
            CustomRoute<dynamic>(
              initial: true,
              page: HomeRoute.page,
              path: AppPaths.home,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: HomeCategoryRoute.page,
              path: AppPaths.category,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: NotificationRoute.page,
              maintainState: false,
              path: AppPaths.notification,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: WishListRoute.page,
              path: AppPaths.wishlist,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
            CustomRoute<dynamic>(
              page: MyAccountRoute.page,
              path: AppPaths.account,
              maintainState: false,
              durationInMilliseconds: Dimens.milliseconds400,
              reverseDurationInMilliseconds: Dimens.milliseconds400,
              transitionsBuilder: fadePageTransition,
            ),
          ],
        ),

        CustomRoute<dynamic>(
          page: SearchRoute.page,
          path: AppPaths.search,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: AddNewAddressRoute.page,
          path: AppPaths.addAddress,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ListAddressRoute.page,
          path: AppPaths.addressList,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: PaymentReviewRoute.page,
          path: AppPaths.payment,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: CheckoutAddressRoute.page,
          path: AppPaths.checkoutAddressPage,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

        CustomRoute<dynamic>(
          page: TrackOrderRoute.page,
          path: AppPaths.trackOrder,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ReferAFriendRoute.page,
          path: AppPaths.referFriend,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),


        CustomRoute<dynamic>(
          page: FilterRoute.page,
          path: AppPaths.filterPage,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ViewCmsRoute.page,
          path: AppPaths.cmspage,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: NotificationSettingRoute.page,
          path: AppPaths.notificationSetting,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: EditProfileRoute.page,
          path: AppPaths.editProfile,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ProductDetailsRoute.page,
          path: AppPaths.productDetails,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: StoreLocationsRoute.page,
          path: AppPaths.storeLocations,
          // don't make it true
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),


        CustomRoute<dynamic>(
          page: MyOrderListingRoute.page,
          path: AppPaths.myOrderListing,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: MyOrderDetailRoute.page,
          path: AppPaths.myOrderDetails,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

        CustomRoute<dynamic>(
          page: MyOrderCancelRoute.page,
          path: AppPaths.myOrderCancel,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: WriteReviewRoute.page,
          path: AppPaths.writeReview,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ReviewRoute.page,
          path: AppPaths.review,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ReviewListingRoute.page,
          path: AppPaths.reviewListing,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

        CustomRoute<dynamic>(
          page: PaymentStatusRoute.page,
          path: AppPaths.paymentSuccessFailure,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),

        CustomRoute<dynamic>(
          page: ViewRewardHistoryRoute.page,
          path: AppPaths.viewRewardsHistory,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: MyWalletRoute.page,
          path: AppPaths.myWallet,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: MyReviewRatingRoute.page,
          path: AppPaths.myReviewRating,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: MyReturnRoute.page,
          maintainState: false,
          path: AppPaths.myReturn,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),


        CustomRoute<dynamic>(
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
          page: ProductListingWithFilterRoute.page,
          path: AppPaths.productListingWithFilter,
        ),
        CustomRoute<dynamic>(
          page: CartListRoute.page,
          path: AppPaths.cartPage,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ProductListingWithFilterRoute.page,
          path: AppPaths.productListingWithFilter,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: SelectAddressRoute.page,
          path: AppPaths.selectAddressPage,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          maintainState: false,
          page: NewAddressAddRoute.page,
          path: AppPaths.addAddressPage,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: CartListRoute.page,
          path: AppPaths.cartPage,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: GiftCardRoute.page,
          path: AppPaths.giftCard,
          maintainState: false,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: ContactUsRoute.page,
          path: AppPaths.contactUs,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: LoyaltyPointsRoute.page,
          path: AppPaths.loyaltyPoints,
          durationInMilliseconds: Dimens.milliseconds400,
          reverseDurationInMilliseconds: Dimens.milliseconds400,
          transitionsBuilder: fadePageTransition,
        ),
        CustomRoute<dynamic>(
          page: PointsHistoryRoute.page,
          path: AppPaths.pointsHistory,
          maintainState: false,
        ),
        CustomRoute<dynamic>(
          page: StoreReceiptRoute.page,
          path: AppPaths.storeReceipt,
        ),
      ];
}

@RoutePage(name: 'TabOne')
///BottomBarTabOnePage
class BottomBarTabOnePage extends AutoRouter {
  ///BottomBarTabOnePage constructor
  const BottomBarTabOnePage({super.key});
}
