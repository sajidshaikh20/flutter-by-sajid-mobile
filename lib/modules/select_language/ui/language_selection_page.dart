import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays language selection options.
class LanguageSelectionPage extends StatelessWidget {
  /// Creates a language selection page.
  const LanguageSelectionPage({super.key});


  @override
  Widget build(BuildContext context) {
      return BlocProvider<LanguageSelectionCubit>(
      create: (_) => LanguageSelectionCubit(
        repository: LanguageSelectionRepositoryImpl(),

      ),
      child: BlocListener<LanguageSelectionCubit, LanguageSelectionState>(
        listenWhen: (LanguageSelectionState previous, LanguageSelectionState current) {
          return previous.status != current.status;
        },
        listener: (BuildContext context, LanguageSelectionState state) async {
          if(state.status == BaseStateStatus.success){
            await context.read<LocaleCubit>().changeLanguage(state.languageCode, state.languageAlignment);
            if(context.mounted) {
              await context.router.replace(state.redirectRoute!);
            }
          }
        },
        child: const LanguageSelectionWidget(),
      ),
    );


  }

}
