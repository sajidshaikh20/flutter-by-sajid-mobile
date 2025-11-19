import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<bool> _isDownloadableFile(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      final String path = uri.path.toLowerCase();

      // Check URL extension
      final List<String> supportedExtensions = <String>[
        '.pdf',
        '.docx',
        '.pptx',
        '.xlsx',
        '.doc',
        '.ppt',
        '.xls'
      ];
      final bool hasExtension =
          supportedExtensions.any((String ext) => path.endsWith(ext));

      if (hasExtension) {
        return true;
      }

      // Check Content-Type header if extension not found
      try {
        final http.Response headResponse =
            await http.head(Uri.parse(url)).timeout(
                  const Duration(seconds: 10),
                );

        final String? contentType =
            headResponse.headers['content-type']?.toLowerCase();
        if (contentType != null) {
          final List<String> supportedMimeTypes = <String>[
            'application/pdf',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            // .docx
            'application/vnd.openxmlformats-officedocument.presentationml.presentation',
            // .pptx
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            // .xlsx
            'application/msword',
            // .doc
            'application/vnd.ms-powerpoint',
            // .ppt
            'application/vnd.ms-excel',
            // .xls
          ];

          return supportedMimeTypes
              .any((String mimeType) => contentType.contains(mimeType));
        }
      } on Exception catch (e) {
        DebugLog.instance.d('Error checking Content-Type: $e');
        // Return false if we can't check, but don't fail the whole check
      }

      return false;
    } on Exception catch (e) {
      DebugLog.instance.e('Error checking if file is downloadable: $e');
      return false;
    }
  }

  Future<void> _downloadFile() async {
    if (_isDownloading) return;

    if (!mounted) return;

    setState(() {
      _isDownloading = true;
    });

    try {
      // Check if URL is a downloadable file
      final bool isDownloadable = await _isDownloadableFile(widget.url);

      if (!isDownloadable) {
        if (!mounted) return;
        displaySnackBar(
            'This file type is not supported for download. Supported: PDF, DOCX, PPTX, XLSX',
            this.context);
        return;
      }

      if (kIsWeb) {
        // For Web/PWA, use browser download
        await _downloadForWeb();
      } else {
        // For mobile platforms
        await _downloadForMobile();
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error downloading file: $e');
      if (mounted) {
        displaySnackBar('Error downloading file: ${e.toString()}', this.context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  Future<void> _downloadForWeb() async {
    try {
      // For web, use anchor element to trigger download
      final http.Response response = await http.head(Uri.parse(widget.url));

      if (response.statusCode == 200 || response.statusCode == 302) {
        // Create a temporary anchor element and trigger download
        // This works better for web browsers
        // Note: Filename extraction is optional for web downloads
        // as the browser handles it automatically based on Content-Disposition

        // Use url_launcher for web download
        if (!mounted) return;

        // For web, we can use url_launcher or create a download link
        final Uri downloadUri = Uri.parse(widget.url);
        // The browser will handle the download based on Content-Type
        // fileName is extracted but browser handles it automatically

        displaySnackBar(
            'Download started. Check your browser downloads.', this.context);

        // Open URL which will trigger browser download
        if (await canLaunchUrl(downloadUri)) {
          await launchUrl(downloadUri, mode: LaunchMode.externalApplication);
        }
      } else {
        if (!mounted) return;
        displaySnackBar(
            'Failed to download file: HTTP ${response.statusCode}', this.context);
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Web download error: $e');
      if (mounted) {
        displaySnackBar('Error downloading file: $e', this.context);
      }
    }
  }

  Future<void> _downloadForMobile() async {
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
        if (!mounted) return;
        displaySnackBar(
            'Storage permission is required to download files', this.context);
        return;
      }

      // Show loading indicator
      await EasyLoading.show(status: 'Downloading...');

      // Get download directory
      Directory directory;
      if (Platform.isAndroid) {
        // Try to get external storage directory
        try {
          directory = await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
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
        String safeFileName =
            widget.fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_').trim();

        if (safeFileName.isEmpty) {
          safeFileName = 'download_${DateTime.now().millisecondsSinceEpoch}';
        }

        final String filePath = '$downloadDir/$safeFileName';
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        await EasyLoading.dismiss();
        if (!mounted) return;
        displaySnackBar('File downloaded to Downloads folder', this.context);
      } else {
        await EasyLoading.dismiss();
        if (!mounted) return;
        displaySnackBar(
            'Failed to download file: HTTP ${response.statusCode}', this.context);
      }
    } on Exception catch (e) {
      await EasyLoading.dismiss();
      DebugLog.instance.e('Download error: $e');
      if (!mounted) return;
      displaySnackBar('Error downloading file: ${e.toString()}', this.context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _isDownloading ? null : _downloadFile,
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
