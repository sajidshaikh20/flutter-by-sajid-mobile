import '../../../../utils/exports.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key, this.isFromNotification = false});

  final bool? isFromNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.appString.navHomeKey)),
      body: const Center(child: Text('Home')),
    );
  }
}
