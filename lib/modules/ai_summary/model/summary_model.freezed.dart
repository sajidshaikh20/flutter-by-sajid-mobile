// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) {
  return _SummaryModel.fromJson(json);
}

/// @nodoc
mixin _$SummaryModel {
  String get originalText => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  int get originalWordCount => throw _privateConstructorUsedError;
  int get summaryWordCount => throw _privateConstructorUsedError;
  String? get translation => throw _privateConstructorUsedError;
  String? get translatedLanguage => throw _privateConstructorUsedError;
  bool get isCached => throw _privateConstructorUsedError;

  /// Serializes this SummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SummaryModelCopyWith<SummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SummaryModelCopyWith<$Res> {
  factory $SummaryModelCopyWith(
          SummaryModel value, $Res Function(SummaryModel) then) =
      _$SummaryModelCopyWithImpl<$Res, SummaryModel>;
  @useResult
  $Res call(
      {String originalText,
      String summary,
      int originalWordCount,
      int summaryWordCount,
      String? translation,
      String? translatedLanguage,
      bool isCached});
}

/// @nodoc
class _$SummaryModelCopyWithImpl<$Res, $Val extends SummaryModel>
    implements $SummaryModelCopyWith<$Res> {
  _$SummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalText = null,
    Object? summary = null,
    Object? originalWordCount = null,
    Object? summaryWordCount = null,
    Object? translation = freezed,
    Object? translatedLanguage = freezed,
    Object? isCached = null,
  }) {
    return _then(_value.copyWith(
      originalText: null == originalText
          ? _value.originalText
          : originalText // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      originalWordCount: null == originalWordCount
          ? _value.originalWordCount
          : originalWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      summaryWordCount: null == summaryWordCount
          ? _value.summaryWordCount
          : summaryWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
      translatedLanguage: freezed == translatedLanguage
          ? _value.translatedLanguage
          : translatedLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SummaryModelImplCopyWith<$Res>
    implements $SummaryModelCopyWith<$Res> {
  factory _$$SummaryModelImplCopyWith(
          _$SummaryModelImpl value, $Res Function(_$SummaryModelImpl) then) =
      __$$SummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String originalText,
      String summary,
      int originalWordCount,
      int summaryWordCount,
      String? translation,
      String? translatedLanguage,
      bool isCached});
}

/// @nodoc
class __$$SummaryModelImplCopyWithImpl<$Res>
    extends _$SummaryModelCopyWithImpl<$Res, _$SummaryModelImpl>
    implements _$$SummaryModelImplCopyWith<$Res> {
  __$$SummaryModelImplCopyWithImpl(
      _$SummaryModelImpl _value, $Res Function(_$SummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalText = null,
    Object? summary = null,
    Object? originalWordCount = null,
    Object? summaryWordCount = null,
    Object? translation = freezed,
    Object? translatedLanguage = freezed,
    Object? isCached = null,
  }) {
    return _then(_$SummaryModelImpl(
      originalText: null == originalText
          ? _value.originalText
          : originalText // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      originalWordCount: null == originalWordCount
          ? _value.originalWordCount
          : originalWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      summaryWordCount: null == summaryWordCount
          ? _value.summaryWordCount
          : summaryWordCount // ignore: cast_nullable_to_non_nullable
              as int,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String?,
      translatedLanguage: freezed == translatedLanguage
          ? _value.translatedLanguage
          : translatedLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SummaryModelImpl implements _SummaryModel {
  const _$SummaryModelImpl(
      {required this.originalText,
      required this.summary,
      required this.originalWordCount,
      required this.summaryWordCount,
      this.translation,
      this.translatedLanguage,
      this.isCached = false});

  factory _$SummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SummaryModelImplFromJson(json);

  @override
  final String originalText;
  @override
  final String summary;
  @override
  final int originalWordCount;
  @override
  final int summaryWordCount;
  @override
  final String? translation;
  @override
  final String? translatedLanguage;
  @override
  @JsonKey()
  final bool isCached;

  @override
  String toString() {
    return 'SummaryModel(originalText: $originalText, summary: $summary, originalWordCount: $originalWordCount, summaryWordCount: $summaryWordCount, translation: $translation, translatedLanguage: $translatedLanguage, isCached: $isCached)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SummaryModelImpl &&
            (identical(other.originalText, originalText) ||
                other.originalText == originalText) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.originalWordCount, originalWordCount) ||
                other.originalWordCount == originalWordCount) &&
            (identical(other.summaryWordCount, summaryWordCount) ||
                other.summaryWordCount == summaryWordCount) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.translatedLanguage, translatedLanguage) ||
                other.translatedLanguage == translatedLanguage) &&
            (identical(other.isCached, isCached) ||
                other.isCached == isCached));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      originalText,
      summary,
      originalWordCount,
      summaryWordCount,
      translation,
      translatedLanguage,
      isCached);

  /// Create a copy of SummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SummaryModelImplCopyWith<_$SummaryModelImpl> get copyWith =>
      __$$SummaryModelImplCopyWithImpl<_$SummaryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SummaryModelImplToJson(
      this,
    );
  }
}

abstract class _SummaryModel implements SummaryModel {
  const factory _SummaryModel(
      {required final String originalText,
      required final String summary,
      required final int originalWordCount,
      required final int summaryWordCount,
      final String? translation,
      final String? translatedLanguage,
      final bool isCached}) = _$SummaryModelImpl;

  factory _SummaryModel.fromJson(Map<String, dynamic> json) =
      _$SummaryModelImpl.fromJson;

  @override
  String get originalText;
  @override
  String get summary;
  @override
  int get originalWordCount;
  @override
  int get summaryWordCount;
  @override
  String? get translation;
  @override
  String? get translatedLanguage;
  @override
  bool get isCached;

  /// Create a copy of SummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SummaryModelImplCopyWith<_$SummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
