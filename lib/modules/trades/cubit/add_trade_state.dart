import '../../../utils/exports.dart';

class AddTradeState extends BaseState {
  const AddTradeState({
    required this.formKey,
    required this.entryController,
    required this.slController,
    required this.tp1Controller,
    required this.tp2Controller,
    required this.tp3Controller,
    required this.tradingViewUrlController,
    required this.commentController,
    required this.pairSearchController,
    this.selectedMarket = 'CRYPTO',
    this.currencyPairs = const <CurrencyPairResponse>[],
    this.selectedPair,
    this.isLoadingPairs = false,
    this.pairSearchQuery = '',
    this.liveSocketPrice,
    this.selectedTradeType = 'BUY_MARKET',
    this.isSlInPips = false,
    this.isTp1InPips = false,
    this.isSubmitting = false,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  // Local Form states (initialized in UI Page / BlocProvider)
  final GlobalKey<FormState> formKey;
  final TextEditingController entryController;
  final TextEditingController slController;
  final TextEditingController tp1Controller;
  final TextEditingController tp2Controller;
  final TextEditingController tp3Controller;
  final TextEditingController tradingViewUrlController;
  final TextEditingController commentController;
  final TextEditingController pairSearchController;

  // Selected parameters
  final String selectedMarket;
  final List<CurrencyPairResponse> currencyPairs;
  final CurrencyPairResponse? selectedPair;
  final bool isLoadingPairs;
  final String pairSearchQuery;
  final double? liveSocketPrice;
  final String selectedTradeType;
  final bool isSlInPips;
  final bool isTp1InPips;
  final bool isSubmitting;

  factory AddTradeState.initial({
    required GlobalKey<FormState> formKey,
    required TextEditingController entryController,
    required TextEditingController slController,
    required TextEditingController tp1Controller,
    required TextEditingController tp2Controller,
    required TextEditingController tp3Controller,
    required TextEditingController tradingViewUrlController,
    required TextEditingController commentController,
    required TextEditingController pairSearchController,
  }) =>
      AddTradeState(
        formKey: formKey,
        entryController: entryController,
        slController: slController,
        tp1Controller: tp1Controller,
        tp2Controller: tp2Controller,
        tp3Controller: tp3Controller,
        tradingViewUrlController: tradingViewUrlController,
        commentController: commentController,
        pairSearchController: pairSearchController,
      );

  bool get isMarketOrder => selectedTradeType.contains('MARKET');

  AddTradeState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    String? selectedMarket,
    List<CurrencyPairResponse>? currencyPairs,
    CurrencyPairResponse? selectedPair,
    bool? isLoadingPairs,
    String? pairSearchQuery,
    double? liveSocketPrice,
    String? selectedTradeType,
    bool? isSlInPips,
    bool? isTp1InPips,
    bool? isSubmitting,
  }) =>
      AddTradeState(
        formKey: formKey,
        entryController: entryController,
        slController: slController,
        tp1Controller: tp1Controller,
        tp2Controller: tp2Controller,
        tp3Controller: tp3Controller,
        tradingViewUrlController: tradingViewUrlController,
        commentController: commentController,
        pairSearchController: pairSearchController,
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        selectedMarket: selectedMarket ?? this.selectedMarket,
        currencyPairs: currencyPairs ?? this.currencyPairs,
        selectedPair: selectedPair ?? this.selectedPair,
        isLoadingPairs: isLoadingPairs ?? this.isLoadingPairs,
        pairSearchQuery: pairSearchQuery ?? this.pairSearchQuery,
        liveSocketPrice: liveSocketPrice ?? this.liveSocketPrice,
        selectedTradeType: selectedTradeType ?? this.selectedTradeType,
        isSlInPips: isSlInPips ?? this.isSlInPips,
        isTp1InPips: isTp1InPips ?? this.isTp1InPips,
        isSubmitting: isSubmitting ?? this.isSubmitting,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        selectedMarket,
        currencyPairs,
        selectedPair,
        isLoadingPairs,
        pairSearchQuery,
        liveSocketPrice,
        selectedTradeType,
        isSlInPips,
        isTp1InPips,
        isSubmitting,
      ];
}
