import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/exports.dart';
import 'ai_summary_repository.dart';

class AiSummaryRepositoryImpl extends AiSummaryRepository {
  AiSummaryRepositoryImpl() : super();

  // API endpoints
  static const String _summaryApiUrl = 'https://api.smmry.com/summarize';
  static const String _translateApiUrl = 'https://libretranslate.com/translate';

  @override
  Future<String> summarizeText(String text) async {
    try {
      // Simple mock summarization - takes first 30% of sentences
      // In production, replace with real API call
      final List<String> sentences = text.split(RegExp(r'[.!?]+')).where((String s) => s.trim().isNotEmpty).toList();
      final int summaryLength = (sentences.length * 0.3).ceil();
      final List<String> summarySentences = sentences.take(summaryLength).toList();
      final String summary = '${summarySentences.join('. ')}.';
      
      // If text is short, return as is
      if (text.split(RegExp(r'\s+')).length < 50) {
        return text;
      }
      
      return summary;

      // Real API call example (uncomment and configure):
      /*
      final response = await http.post(
        Uri.parse(_summaryApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['summary'] as String;
      } else {
        throw Exception('Summary API failed: ${response.statusCode}');
      }
      */
    } on Exception catch (e) {
      DebugLog.instance.e('Error in summarizeText: $e');
      // Fallback to simple truncation
      final List<String> words = text.split(RegExp(r'\s+'));
      if (words.length > 100) {
        return '${words.take(100).join(' ')}...';
      }
      return text;
    }
  }

  @override
  Future<String> translateText(String text, String targetLanguage) async {
    try {
      // Language code mapping for LibreTranslate
      // LibreTranslate uses ISO 639-1 codes
      final Map<String, String> languageCodeMap = <String, String>{
        'en': 'en',
        'hi': 'hi',
        'es': 'es',
        'fr': 'fr',
        'de': 'de',
        'ur': 'ur',
        'ar': 'ar',
        'zh': 'zh',
        'ja': 'ja',
        'pt': 'pt',
        'ru': 'ru',
        'it': 'it',
      };

      // Get the mapped language code, default to 'en' if not found
      final String mappedTargetLanguage = languageCodeMap[targetLanguage.toLowerCase()] ?? targetLanguage.toLowerCase();
      
      // Auto-detect source language (empty string means auto-detect)
      final String sourceLanguage = '';

      // Make API call to LibreTranslate
      final http.Response response = await http.post(
        Uri.parse(_translateApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'q': text,
          'source': sourceLanguage,
          'target': mappedTargetLanguage,
          'format': 'text',
          'api_key': '', // Optional: Add API key if you have one
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
        final String? translatedText = data['translatedText'] as String?;
        
        if (translatedText != null && translatedText.isNotEmpty) {
          return translatedText;
        } else {
          throw Exception('Translation API returned empty response');
        }
      } else {
        throw Exception('Translation API failed with status code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error in translateText: $e');
      // Return original text on error
      return text;
    }
  }
}

