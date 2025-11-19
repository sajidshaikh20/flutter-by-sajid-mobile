import '../../../utils/exports.dart';
import '../model/summary_model.dart';

class AiSummaryState extends BaseState {
  const AiSummaryState({
    required super.status,
    super.redirectRoute,
    super.msg,
    this.summary,
    this.isTranslating = false,
  });

  final SummaryModel? summary;
  final bool isTranslating;

  AiSummaryState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    SummaryModel? summary,
    bool? isTranslating,
  }) {
    return AiSummaryState(
      status: status ?? this.status,
      redirectRoute: redirectRoute ?? this.redirectRoute,
      msg: msg ?? this.msg,
      summary: summary ?? this.summary,
      isTranslating: isTranslating ?? this.isTranslating,
    );
  }

  static AiSummaryState initial() {
    return const AiSummaryState(
      status: BaseStateStatus.initial,
    );
  }
}

