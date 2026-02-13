import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the main screen (first screen after splash).
class MainPage extends StatelessWidget {
  /// Creates a main page.
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (BuildContext _) {
        final MainCubit cubit = MainCubit();
        unawaited(cubit.loadData());
        return cubit;
      },
      child: const MainViewWidget(),
    );
  }
}
