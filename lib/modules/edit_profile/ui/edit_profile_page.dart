import '../../../utils/exports.dart';

/// Page to edit user profile information.
///
/// Uses [EditProfileForm] wrapped with a [BlocProvider] for state management
/// via [EditProfileCubit]. Supports responsive layouts for mobile, tablet,
/// and desktop using [BaseResponsiveView].
@RoutePage()
class EditProfilePage extends BaseResponsiveView {
  /// The existing profile data to populate the form initially.
  final MyAccountInfoModel editProfile;
///EditProfilePage
  const EditProfilePage({super.key, required this.editProfile});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }

  /// Builds the main view for the page based on device type.
  Widget _buildView(BuildContext context, ScreenType device) {
    // Convert MyAccountInfoModel to UserProfileModel for form population
    final UserProfileModel userProfile = UserProfileModel(
      customerId: editProfile.customerId,
      customerName: editProfile.firstName ?? '',
      lastName: editProfile.lastName ?? '',
      customerEmail: editProfile.email ?? '',
      mobileNumber: editProfile.mobilenumber ?? '',
      phoneNumber: editProfile.mobilenumber ?? '',
      prefix: editProfile.mobileNumberPrefix ?? 0,
      quoteId: editProfile.quoteId ?? '',
      // Required fields with default values
      customerToken: '', // Will be loaded from UserProfileService
      referralCode: '',
      fcmToken: '',
      gender: '',
      birthday: '',
      nationality: '',
      totalOrderValue: '0',
      lastOrderDate: '',
      storeCredit: '0',
      rewardPoints: '0',
      totalOrder: 0,
      arabicNationality: ''
    );
    
    return BlocProvider<EditProfileCubit>(
      create: (BuildContext context) => EditProfileCubit(
        repository: EditProfileRepositoryImpl(),
        initial: EditProfileState.init(userProfile: userProfile),
      ),
      child: EditProfileForm(device: device),
    );
  }
}
