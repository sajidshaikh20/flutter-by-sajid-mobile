import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../utils/exports.dart';

@RoutePage()
class PdfViewScreen extends StatelessWidget {
  final String pdfPath;
  final String title;

  const PdfViewScreen({
    super.key,
    required this.pdfPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    
    Widget pdfViewerWidget;
    
    if (pdfPath.startsWith('/mock')) {
      // For mock PDF, we load a sample public PDF so that the preview actually works.
      pdfViewerWidget = SfPdfViewer.network(
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      );
    } else if (pdfPath.startsWith('http://') || pdfPath.startsWith('https://')) {
      pdfViewerWidget = SfPdfViewer.network(
        pdfPath,
      );
    } else {
      // Local file
      pdfViewerWidget = SfPdfViewer.file(
        File(pdfPath),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomTextLabelWidget(
          label: title,
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.bold,
            fontSize: Dimens.fontSize16,
          ),
        ),
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
        elevation: 0.5,
      ),
      body: pdfViewerWidget,
    );
  }
}
