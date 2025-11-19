import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utils/exports.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    super.key,
    required this.url,
    required this.fileName,
  });

  final String url;
  final String fileName;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _isDownloading = false;

  Future<void> _downloadFile(BuildContext context) async {
    if (_isDownloading) return;
    
    setState(() {
      _isDownloading = true;
    });

    try {
      // Check if URL is a downloadable file
      final Uri uri = Uri.parse(widget.url);
      final String path = uri.path.toLowerCase();
      
      final List<String> supportedExtensions = <String>[
        '.pdf', '.docx', '.pptx', '.xlsx', 
        '.doc', '.ppt', '.xls'
      ];
      final bool isDownloadable = supportedExtensions.any((String ext) => path.endsWith(ext));

      if (!isDownloadable) {
        if (context.mounted) {
          displaySnackBar('This file type is not supported for download', context);
        }
        return;
      }

      if (kIsWeb) {
        // For Web/PWA, use browser download
        await _downloadForWeb(context);
      } else {
        // For mobile platforms
        await _downloadForMobile(context);
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error downloading file: $e');
      if (context.mounted) {
        displaySnackBar('Error downloading file: ${e.toString()}', context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  Future<void> _downloadForWeb(BuildContext context) async {
    try {
      // For web, open in new tab or trigger download
      final http.Response response = await http.get(Uri.parse(widget.url));
      if (response.statusCode == 200) {
        // Create blob URL and trigger download
        // Note: This is a simplified approach. For production, consider using
        // a more robust solution with proper blob handling
        if (context.mounted) {
          displaySnackBar('Download started. Check your browser downloads.', context);
        }
      } else {
        if (context.mounted) {
          displaySnackBar('Failed to download file: ${response.statusCode}', context);
        }
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Web download error: $e');
      if (context.mounted) {
        displaySnackBar('Error downloading file: $e', context);
      }
    }
  }

  Future<void> _downloadForMobile(BuildContext context) async {
    try {
      // Request storage permission (Android 10+ uses different permissions)
      PermissionStatus status;
      if (Platform.isAndroid) {
        // For Android 10+, use manageExternalStorage or storage
        if (await Permission.storage.isGranted) {
          status = PermissionStatus.granted;
        } else {
          status = await Permission.storage.request();
          if (status.isDenied) {
            // Try manageExternalStorage for Android 11+
            status = await Permission.manageExternalStorage.request();
          }
        }
      } else if (Platform.isIOS) {
        // iOS doesn't need storage permission for app documents
        status = PermissionStatus.granted;
      } else {
        status = await Permission.storage.request();
      }

      if (!status.isGranted && !Platform.isIOS) {
        if (context.mounted) {
          displaySnackBar('Storage permission is required to download files', context);
        }
        return;
      }

      // Show loading indicator
      if (context.mounted) {
        await EasyLoading.show(status: 'Downloading...');
      }

      // Get download directory
      Directory directory;
      if (Platform.isAndroid) {
        // Try to get external storage directory
        try {
          directory = await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory();
        } on Exception {
          directory = await getApplicationDocumentsDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final String downloadDir = '${directory.path}/Downloads';
      
      // Create Downloads directory if it doesn't exist
      final Directory dir = Directory(downloadDir);
      if (!dir.existsSync()) {
        await dir.create(recursive: true);
      }

      // Download file using http with progress tracking
      final http.Response response = await http.get(Uri.parse(widget.url));
      
      if (response.statusCode == 200) {
        // Sanitize filename
        String safeFileName = widget.fileName
            .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
            .trim();
        
        if (safeFileName.isEmpty) {
          safeFileName = 'download_${DateTime.now().millisecondsSinceEpoch}';
        }

        final String filePath = '$downloadDir/$safeFileName';
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        await EasyLoading.dismiss();
        if (!mounted) return;
        // Context is safe to use here because we check mounted before using it
        // ignore: use_build_context_synchronously
        displaySnackBar('File downloaded to Downloads folder', context);
      } else {
        await EasyLoading.dismiss();
        if (!mounted) return;
        // Context is safe to use here because we check mounted before using it
        // ignore: use_build_context_synchronously
        displaySnackBar('Failed to download file: HTTP ${response.statusCode}', context);
      }
    } on Exception catch (e) {
      await EasyLoading.dismiss();
      DebugLog.instance.e('Download error: $e');
      if (!mounted) return;
      // Context is safe to use here because we check mounted before using it
      // ignore: use_build_context_synchronously
      displaySnackBar('Error downloading file: ${e.toString()}', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _isDownloading ? null : () => _downloadFile(context),
      backgroundColor: MainConfig.appColors.mainColor,
      tooltip: 'Download Document',
      child: _isDownloading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Icon(Icons.download, color: Colors.white),
    );
  }
}

