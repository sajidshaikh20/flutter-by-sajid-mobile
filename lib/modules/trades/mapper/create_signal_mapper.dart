// This class only contains static mapping methods to construct CreateSignalRequest.
// ignore_for_file: avoid_classes_with_only_static_members
import '../model/request/create_signal_request.dart';

class CreateSignalMapper {
  static CreateSignalRequest toRequest({
    required String market,
    required String marketType,
    required int? currencyPairId,
    required String note,
    required String tradingViewUrl,
    required double rrVal,
    required double entry,
    required double sl,
    required double tp1,
    required double slPips,
    required double tp1Pips,
    required double? tp2Val,
    required double? tp2Pips,
    required double? tp3Val,
    required double? tp3Pips,
  }) {
    final List<CreateSignalLevel> levels = <CreateSignalLevel>[
      CreateSignalLevel(
        levelType: 'ENTRY',
        entryPoint: entry,
        stopLoss: sl,
        takeProfit: tp1,
        level: 0,
        entryPips: 0,
        slPips: slPips,
        tpPips: tp1Pips,
      ),
    ];

    if (tp2Val != null && tp2Val > 0 && tp2Pips != null) {
      levels.add(
        CreateSignalLevel(
          levelType: 'TAKE_PROFIT',
          entryPoint: entry,
          stopLoss: sl,
          takeProfit: tp2Val,
          level: 2,
          entryPips: 0,
          slPips: slPips,
          tpPips: tp2Pips,
        ),
      );
    }

    if (tp3Val != null && tp3Val > 0 && tp3Pips != null) {
      levels.add(
        CreateSignalLevel(
          levelType: 'TAKE_PROFIT',
          entryPoint: entry,
          stopLoss: sl,
          takeProfit: tp3Val,
          level: 3,
          entryPips: 0,
          slPips: slPips,
          tpPips: tp3Pips,
        ),
      );
    }

    return CreateSignalRequest(
      market: market,
      marketType: marketType,
      currencyPairId: currencyPairId,
      note: note,
      tradingViewUrl: tradingViewUrl,
      riskRewardRatio: '1:${rrVal.toStringAsFixed(2)}',
      slPips: slPips,
      tpPips: tp1Pips,
      levels: levels,
    );
  }
}
