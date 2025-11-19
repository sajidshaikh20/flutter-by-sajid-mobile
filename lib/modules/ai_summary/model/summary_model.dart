import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../utils/exports.dart';

part 'summary_model.freezed.dart';
part 'summary_model.g.dart';

@freezed
class SummaryModel with _$SummaryModel {
  const factory SummaryModel({
    required String originalText,
    required String summary,
    required int originalWordCount,
    required int summaryWordCount,
    String? translation,
    String? translatedLanguage,
    @Default(false) bool isCached,
  }) = _SummaryModel;

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);
}

extension SummaryModelExtension on SummaryModel {
  double get reductionPercentage {
    if (originalWordCount == 0) return 0.0;
    return ((originalWordCount - summaryWordCount) / originalWordCount) * 100;
  }
}

