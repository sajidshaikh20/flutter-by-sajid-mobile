import '../../../../utils/exports.dart';

@RoutePage()
/// A page widget that allows the user to change the app's language.
///
/// This page typically provides a list of available languages and handles
/// updating the app's locale when the user selects a different language.
class ChangeLanguagePage extends StatelessWidget {
  /// Creates a [ChangeLanguagePage] widget.
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageSelectionCubit>(
      create: (_) => LanguageSelectionCubit(
        repository: LanguageSelectionRepositoryImpl(),
      ),
      child: BlocListener<LanguageSelectionCubit, LanguageSelectionState>(
        listenWhen:
            (LanguageSelectionState previous, LanguageSelectionState current) {
          return previous.status != current.status;
        },
        listener: (BuildContext context, LanguageSelectionState state) async {
          if (state.status == BaseStateStatus.success) {
            await context
                .read<LocaleCubit>()
                .changeLanguage(state.languageCode, state.languageAlignment);
            if (context.mounted) {
              goBack(context);
            }
          }
        },
        child: const ChangeLanguageWidget(),
      ),
    );
  }
}
