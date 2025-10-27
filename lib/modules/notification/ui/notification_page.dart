
import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the list of notifications with read/unread status.
class NotificationPage extends BaseResponsiveView {
  /// Creates a notification page.
  const NotificationPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildViews(context,ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildViews(context,ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildViews(context,ScreenType.tablet);
  }


  /// Builds the notification view with BlocProvider for the specified device type.
  Widget buildViews(BuildContext context,ScreenType device) {

    return BlocProvider<NotificationCubit>(
      create: (BuildContext context) => NotificationCubit(notificationRepository: NotificationRepositoryImpl()),
      child:  _pageView(context,device),
    );
  }

  Widget _pageView(BuildContext ctx,ScreenType device) {
    return BlocListener<NotificationCubit, NotificationState>(
      listenWhen: (NotificationState previous, NotificationState current) {
        return current.status != previous.status;
      },
      listener: (BuildContext context, NotificationState state) {
        if (state.msg.isNotNullOrEmpty) {
          displaySnackBar(state.msg.toString(), context);
        }
      },
      child:  NotificationPageWidget(device: device),
    );
  }
}
