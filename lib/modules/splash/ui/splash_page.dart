import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the splash screen with initialization logic.
class SplashPage extends StatelessWidget {
  /// Creates a splash page.
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit( ),
      child: BlocListener<SplashCubit, SplashState>(
          listenWhen: (SplashState previous, SplashState current) => current.redirectPath.isNotEmpty,
          listener: (BuildContext context, SplashState state) async {
            if (state.redirectPath.isNotEmpty) {
              await context.read<LocaleCubit>().changeLanguageOnInit(state.languageCode, state.languageAlignment);

            if(context.mounted) {
                await context.router.replaceNamed(state.redirectPath);
              }

            }
          },
          child: const SplashViewWidget()),
    );
  }
}
