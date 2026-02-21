import '../../../utils/exports.dart';

@RoutePage()
class ChatSupportPage extends BaseResponsiveView {
  const ChatSupportPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);
  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);
  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<ChatSupportCubit>(
      create: (BuildContext c) => ChatSupportCubit(),
      child: const Scaffold(
        body: Center(child: Text('Chat Support')),
      ),
    );
  }
}
