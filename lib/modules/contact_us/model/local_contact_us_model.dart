import '../../../utils/exports.dart';

/// Model representing a single contact item in the Contact Us section.
/// 
/// This model holds the data structure for contact information items
/// displayed in the contact us screen.
class LocalContactUsModel {
  /// The main title of the contact item (e.g., "Customer Support").
  String? title;

  /// The first subtitle, usually additional information or description.
  String? subTitle;

  /// The second subtitle, optional extra information.
  String? secondSubTitle;

  /// Optional image or icon associated with the contact item.
  SvgGenImage? imageWidget;

  /// The type of contact item, represented by `ContactListType`.
  ContactListType? type;

  /// Creates a [LocalContactUsModel] instance.
  LocalContactUsModel({
    this.title,
    this.subTitle,
    this.secondSubTitle,
    this.imageWidget,
    this.type,
  });
}
