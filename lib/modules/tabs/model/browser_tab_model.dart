import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../utils/exports.dart';

part 'browser_tab_model.freezed.dart';
part 'browser_tab_model.g.dart';

@freezed
class BrowserTabModel with _$BrowserTabModel {
  const factory BrowserTabModel({
    required String id,
    required String url,
    String? title,
    String? favicon,
    @Default(false) bool isLoading,
    @Default(false) bool canGoBack,
    @Default(false) bool canGoForward,
    @Default(0.0) double progress,
  }) = _BrowserTabModel;

  factory BrowserTabModel.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabModelFromJson(json);
}

extension BrowserTabModelExtension on BrowserTabModel {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'favicon': favicon,
      'isLoading': isLoading,
      'canGoBack': canGoBack,
      'canGoForward': canGoForward,
      'progress': progress,
    };
  }

  static BrowserTabModel fromMap(Map<String, dynamic> map) {
    return BrowserTabModel(
      id: map['id'] as String,
      url: map['url'] as String,
      title: map['title'] as String?,
      favicon: map['favicon'] as String?,
      isLoading: map['isLoading'] as bool? ?? false,
      canGoBack: map['canGoBack'] as bool? ?? false,
      canGoForward: map['canGoForward'] as bool? ?? false,
      progress: (map['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

