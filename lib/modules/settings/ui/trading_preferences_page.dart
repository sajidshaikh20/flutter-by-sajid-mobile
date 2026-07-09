import '../../../utils/exports.dart';
import '../cubit/trading_preferences_cubit.dart';
import 'widget/trading_preferences_form.dart';

@RoutePage()
class TradingPreferencesPage extends BaseResponsiveView {
  const TradingPreferencesPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  Widget _buildView(BuildContext context) {
    return BlocProvider<TradingPreferencesCubit>(
      create: (BuildContext context) {
        final TradingPreferencesCubit cubit = TradingPreferencesCubit(
          profileRepository: ProfileRepositoryImpl(),
        );
        unawaited(cubit.loadPreferences());
        return cubit;
      },
      child: const TradingPreferencesForm(),
    );
  }
}
