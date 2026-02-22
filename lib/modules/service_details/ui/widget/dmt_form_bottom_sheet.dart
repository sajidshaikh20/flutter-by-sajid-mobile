import '../../../../utils/exports.dart';
import 'dmt_form_content.dart';

/// Shows the DMT transaction form bottom sheet (reuses [showCommonBottomSheet]).
/// Static UI – exact like design. [dmtLabel] is the title (e.g. "DMT-1", "DMT-2").
Future<void> showDmtFormBottomSheet(
  BuildContext context, {
  required String dmtLabel,
}) async {
  await showCommonBottomSheet<void>(
    context: context,
    child: DmtFormContent(dmtLabel: dmtLabel),
  );
}
