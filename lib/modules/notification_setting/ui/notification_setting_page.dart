import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays notification settings for order status, promotions, and loyalty points.
class NotificationSettingPage extends StatefulWidget {
  /// Creates a notification setting page.
  const NotificationSettingPage({
    super.key,
    this.orderStatus,
    this.promotionOffers,
    this.loyalityPoints,
  });

  /// Initial value for order status notifications.
  final bool? orderStatus;

  /// Initial value for promotion offers notifications.
  final bool? promotionOffers;

  /// Initial value for loyalty points notifications.
  final bool? loyalityPoints;

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  bool _hasChanges = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          DebugLog.instance.i('NotificationSettingPage: Back button pressed, returning result: $_hasChanges');
          // Defer the pop operation to avoid Navigator lock conflict
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pop(_hasChanges);
            }
          });
        }
      },
      child: NoInternetWidget(
        onTryAgain: () {},
        childWidget: Scaffold(
          backgroundColor: MainConfig.appColors.backgroundWhiteColor,
          body: BlocProvider<NotificationSettingCubit>(
          create: (BuildContext context) {
            DebugLog.instance.i('NotificationSettingPage: Creating cubit with initial values:');
            DebugLog.instance.i('  - orderStatus: ${widget.orderStatus}');
            DebugLog.instance.i('  - loyalityPoints: ${widget.loyalityPoints}');
            DebugLog.instance.i('  - promotionOffers: ${widget.promotionOffers}');
            
            return NotificationSettingCubit(
              repository: NotificationSettingRepositoryImpl(),
              initialOrderStatus: widget.orderStatus,
              initialLoyaltyPoints: widget.loyalityPoints,
              initialPromotionOffers: widget.promotionOffers,
            );
          },
            child: BlocListener<NotificationSettingCubit, NotificationSettingState>(
              listener: (BuildContext context, NotificationSettingState state) {
                if (state is NotificationSettingInitial && state.status == BaseStateStatus.success) {
                  _hasChanges = true;
                  DebugLog.instance.i('NotificationSettingPage: Changes detected, setting _hasChanges = true');
                }
              },
              child: const NotificationSettingWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
