import '../../../utils/exports.dart';

@RoutePage()
class AddTradePage extends BaseResponsiveView {
  const AddTradePage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<AddTradeCubit>(
      create: (BuildContext context) => AddTradeCubit(
        repository: TradesRepositoryImpl(),
        initialState: AddTradeState.initial(
          formKey: GlobalKey<FormState>(),
          entryController: TextEditingController(),
          slController: TextEditingController(),
          tp1Controller: TextEditingController(),
          tp2Controller: TextEditingController(),
          tp3Controller: TextEditingController(),
          tradingViewUrlController: TextEditingController(),
          commentController: TextEditingController(),
          pairSearchController: TextEditingController(),
        ),
      ),
      child: const AddTradeForm(),
    );
  }
}

class AddTradeForm extends StatelessWidget {
  const AddTradeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? const Color(0xFF0F1218) : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return BlocConsumer<AddTradeCubit, AddTradeState>(
      listener: (BuildContext context, AddTradeState state) async {
        if (state.msg != null && state.msg!.isNotEmpty) {
          if (state.status == BaseStateStatus.success) {
            context.scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(state.msg!),
                backgroundColor: AppColors.successColor,
              ),
            );
            try {
             // AutoTabsRouter.of(context).setActiveIndex(1);
              AutoTabsRouter.of(context).setActiveIndex(2);
              //await context.read<MyTradesCubit>().loadMyTrades(isRefresh: true);
            } on Object catch (_) {

            }
          } else if (state.status == BaseStateStatus.failure) {
            context.scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(state.msg!),
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
          if(context.mounted){
            context.read<AddTradeCubit>().resetError();
          }
        }
      },
      builder: (BuildContext context, AddTradeState state) {
        return Scaffold(
          backgroundColor: pageBg,
          appBar: AppBar(
            backgroundColor: pageBg,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor, size: 18),
              onPressed: () {
                try {
                  AutoTabsRouter.of(context).setActiveIndex(0);
                } on Object catch (_) {
                  unawaited(context.router.maybePop());
                }
              },
            ),
            title: Text(
              'Add New Trade',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Create a premium signal with smart entries, SL, TP and auto RR insights.',
                      style: TextStyle(
                        color: subtextColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const MarketTypeDropdown(),
                    const SizedBox(height: 18),
                    const PairSelector(),
                    const SizedBox(height: 18),
                    const LivePriceCard(),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: TradeTypeDropdown()),
                        SizedBox(width: 12),
                        Expanded(child: EntryPriceField()),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: StopLossField()),
                        SizedBox(width: 12),
                        Expanded(child: TakeProfitFields()),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const ValidationWarningBox(),
                    const RiskRewardRatioCard(),
                    const SizedBox(height: 18),
                    const TradingViewUrlField(),
                    const SizedBox(height: 18),
                    const TradeNotesField(),
                    const SizedBox(height: 28),
                    const PublishTradeButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
