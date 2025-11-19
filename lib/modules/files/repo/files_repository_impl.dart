import '../../../service/storage/storage_service.dart';
import '../../../utils/exports.dart';
import '../model/file_model.dart';
import 'files_repository.dart';

class FilesRepositoryImpl extends FilesRepository {
  FilesRepositoryImpl() : super();

  @override
  Future<List<FileModel>> getAllFiles() async {
    try {
      final List<Map<String, dynamic>> filesData = getIt<StorageService>().getAllFiles();
      final List<FileModel> files = filesData.map((Map<String, dynamic> map) => FileModel.fromMap(map)).toList()
      ..sort((FileModel a, FileModel b) => b.dateCreated.compareTo(a.dateCreated));
      return files;
    } on Exception catch (e) {
      DebugLog.instance.e('Error getting all files: $e');
      return <FileModel>[];
    }
  }

  @override
  Future<void> saveFile(FileModel file) async {
    try {
      await getIt<StorageService>().saveFileMetadata(file.id, file.toMap());
    } on Exception catch (e) {
      DebugLog.instance.e('Error saving file: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteFile(FileModel file) async {
    try {
      await getIt<StorageService>().deleteFileMetadata(file.id);
      // Also delete the actual file if it exists
      try {
        final File fileObj = File(file.path);
        if (fileObj.existsSync()) {
          await fileObj.delete();
        }
      } on Exception catch (e) {
        DebugLog.instance.e('Error deleting physical file: $e');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error deleting file metadata: $e');
      rethrow;
    }
  }

  @override
  Future<void> openFile(FileModel file) async {
    try {
      final OpenResult result = await OpenFilex.open(file.path);
      if (result.type != ResultType.done) {
        throw Exception('Failed to open file: ${result.message}');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error opening file: $e');
      rethrow;
    }
  }
}

