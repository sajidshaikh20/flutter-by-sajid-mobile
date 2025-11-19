import '../../../utils/exports.dart';
import '../model/file_model.dart';

abstract class FilesRepository extends BaseRepository {
  FilesRepository();

  Future<List<FileModel>> getAllFiles();
  Future<void> saveFile(FileModel file);
  Future<void> deleteFile(FileModel file);
  Future<void> openFile(FileModel file);
}

