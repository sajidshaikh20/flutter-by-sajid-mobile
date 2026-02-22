import '../../../../utils/exports.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key, this.isFromNotification = false});

  final bool? isFromNotification;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (BuildContext c) => HomeCubit(),
      child: const SafeArea(
        child: Scaffold(
          body: HomeViewWidget(),
        ),
      ),
    );
  }
}
