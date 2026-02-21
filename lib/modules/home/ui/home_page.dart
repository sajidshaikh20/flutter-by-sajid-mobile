import '../../../../utils/exports.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key, this.isFromNotification = false});

  final bool? isFromNotification;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home')),
    );
  }
}
