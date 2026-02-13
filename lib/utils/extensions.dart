import 'exports.dart';

/// A placeholder abstract class to group extension declarations.
/// This class is not meant to be instantiated.
abstract class Extensions {}

/// Extensions on [num] that provide shortcuts for creating common
/// Flutter UI objects such as borders, radii, paddings, and input borders.
extension BorderRadiusExt on num {
  /// Creates a [BoxBorder] with the specified parameters.
  /// Defaults to `MainConfig.appColors.textBlackColor` if [color] is null.
  BoxBorder borderAll({
    Color? color,
    double? strokeAlign,
    BorderStyle? style,
  }) =>
      Border.all(
        color: color ?? MainConfig.appColors.textBlackColor,
        width: toDouble(),
      );

  /// Returns a circular [BorderRadius] with the current number as radius.
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());

  /// Returns a [BorderRadius] with top-left and top-right corners rounded.
  BorderRadius get borderRadiusTopLeftTopRight => BorderRadius.only(
    topLeft: Radius.circular(toDouble()),
    topRight: Radius.circular(toDouble()),
  );

  /// Returns a circular [Radius] with the current number as radius.
  Radius get circularRadius => Radius.circular(toDouble());

  /// Returns [EdgeInsets.all] using the current number as padding.
  EdgeInsetsGeometry get padding => EdgeInsets.all(toDouble());

  /// Creates an [OutlineInputBorder] with the current number as border radius.
  InputBorder outlineInputBorder({
    BorderSide borderSide = BorderSide.none,
  }) =>
      OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      );

  /// Creates an [UnderlineInputBorder] with the current number as border radius.
  InputBorder underlineInputBorder({
    BorderSide borderSide = BorderSide.none,
  }) =>
      UnderlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      );

  /// Creates a [BorderSide] with the current number as width.
  /// Defaults to `MainConfig.appColors.borderColorWhite` if [color] is null.
  BorderSide borderSide({
    Color? color,
    double? strokeAlign,
    BorderStyle? style,
  }) =>
      BorderSide(
        color: color ?? MainConfig.appColors.borderColorWhite,
        width: toDouble(),
        style: style ?? BorderStyle.solid,
        strokeAlign: strokeAlign ?? -1.0,
      );
}

/// Extension on [String] to convert hexadecimal color codes into [Color] objects.
extension HexColorExt on String {
  /// Converts the string to a [Color] assuming it’s in HEX format.
  /// Supports strings with or without `#` prefix.
  Color get fromHex {
    final StringBuffer buffer = StringBuffer();
    if (length == 6 || length == 7) {
      buffer.write('ff');
    }

    if (startsWith('#')) {
      buffer.write(replaceFirst('#', ''));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

/// Extension on nullable [bool] to provide `isTrue` and `isFalse` helpers.
extension RxnBoolExt on bool? {
  /// Returns the value as is, representing a "true" check.
  bool? get isTrue => this;

  /// Returns the opposite of [isTrue] if not null, otherwise returns null.
  bool? get isFalse {
    if (this != null) return !isTrue!;
    return null;
  }
}





/// Extension on [num] for quickly creating [SizedBox] instances.
extension SizedBoxExtensions on num {
  /// Returns a [SizedBox] with the current number as height.
  SizedBox get heightBox => SizedBox(height: toDouble());

  /// Returns a [SizedBox] with the current number as width.
  SizedBox get widthBox => SizedBox(width: toDouble());
}

/// Extension on [BoxDecoration] to provide reusable decoration styles.
extension BoxDecorationExtension on BoxDecoration {
  /// Creates a custom [BoxDecoration] with optional parameters.
  static BoxDecoration customDecoration({
    Color? color,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    BoxShape? shape,
    DecorationImage? image,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
  }) {
    return BoxDecoration(
      shape: shape ?? BoxShape.rectangle,
      image: image,
      gradient: gradient,
      backgroundBlendMode: backgroundBlendMode,
      color: color,
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow,
    );
  }
}

/// Extension on [num] to convert a line height and font size into a height ratio for [TextStyle].
extension LineHeightExtension on num {
  /// Converts the desired line height and font size into a [TextStyle.height] ratio.
  double toLineHeight(num fontSize) {
    return this / fontSize;
  }
}

/// Extension on [LanguageCode] to get its string representation.
extension LanguageCodeExtension on LanguageCode {
  /// Returns the language code string (`"en"` or `"ar"`).
  String get code {
    switch (this) {
      case LanguageCode.en:
        return AppConstant.en;
      case LanguageCode.ar:
        return AppConstant.ar;
    }
  }
}

