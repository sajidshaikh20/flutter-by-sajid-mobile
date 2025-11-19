import '../../../utils/exports.dart';

abstract class AiSummaryRepository extends BaseRepository {
  AiSummaryRepository();

  /// Summarize the given text using AI
  Future<String> summarizeText(String text);

  /// Translate text to target language
  Future<String> translateText(String text, String targetLanguage);
}

