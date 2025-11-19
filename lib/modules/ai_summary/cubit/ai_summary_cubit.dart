import '../../../utils/exports.dart';


class AiSummaryCubit extends BaseCubit<AiSummaryState> {
  AiSummaryCubit({AiSummaryRepository? repository})
      : _repository = repository ?? AiSummaryRepositoryImpl(),
        super(AiSummaryState.initial());

  final AiSummaryRepository _repository;

  Future<void> summarizeText(String text) async {
    if (text.trim().isEmpty) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Text is empty',
      ));
      return;
    }

    // Check cache first
    final String contentHash = _generateContentHash(text);
    final Map<String, dynamic>? cachedSummary = getIt<StorageService>().getCachedSummary(contentHash);
    
    if (cachedSummary != null) {
      final SummaryModel summary = SummaryModel(
        originalText: cachedSummary['originalText'] as String,
        summary: cachedSummary['summary'] as String,
        originalWordCount: cachedSummary['originalWordCount'] as int,
        summaryWordCount: cachedSummary['summaryWordCount'] as int,
        isCached: true,
      );
      emit(state.copyWith(
        summary: summary,
        status: BaseStateStatus.success,
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      final int wordCount = text.split(RegExp(r'\s+')).length;
      
      // Call AI summarization API (mock implementation)
      final String summaryText = await _repository.summarizeText(text);
      final int summaryWordCount = summaryText.split(RegExp(r'\s+')).length;

      final SummaryModel summary = SummaryModel(
        originalText: text,
        summary: summaryText,
        originalWordCount: wordCount,
        summaryWordCount: summaryWordCount,
        isCached: false,
      );

      // Cache the summary
      await getIt<StorageService>().cacheSummary(contentHash, <String, dynamic>{
        'originalText': text,
        'summary': summaryText,
        'originalWordCount': wordCount,
        'summaryWordCount': summaryWordCount,
      });

      emit(state.copyWith(
        summary: summary,
        status: BaseStateStatus.success,
      ));
    } on Exception catch (e) {
      DebugLog.instance.e('Error summarizing text: $e');
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to summarize: $e',
      ));
    }
  }

  Future<void> translateSummary(String targetLanguage) async {
    if (state.summary == null) return;

    emit(state.copyWith(isTranslating: true));

    try {
      final String translatedText = await _repository.translateText(
        state.summary!.summary,
        targetLanguage,
      );

      final SummaryModel updatedSummary = state.summary!.copyWith(
        translation: translatedText,
        translatedLanguage: targetLanguage,
      );

      emit(state.copyWith(
        summary: updatedSummary,
        isTranslating: false,
        status: BaseStateStatus.success,
      ));
    } on Exception catch (e) {
      DebugLog.instance.e('Error translating text: $e');
      emit(state.copyWith(
        isTranslating: false,
        status: BaseStateStatus.failure,
        msg: 'Failed to translate: $e',
      ));
    }
  }

  void clearSummary() {
    emit(AiSummaryState.initial());
  }

  void clearTranslation() {
    if (state.summary != null) {
      final SummaryModel updatedSummary = state.summary!.copyWith(
        translation: null,
        translatedLanguage: null,
      );
      emit(state.copyWith(summary: updatedSummary));
    }
  }

  String _generateContentHash(String text) {
    final Uint8List bytes = utf8.encode(text);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  AiSummaryState getResetErrorState() => state.copyWith(msg: '');

  @override
  AiSummaryState getResetRedirectionState() => state.copyWith();
}

