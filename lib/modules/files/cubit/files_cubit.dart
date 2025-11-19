import 'package:file_picker/file_picker.dart' as file_picker show FilePickerResult, PlatformFile, FileType;
import '../../../utils/exports.dart';

class FilesCubit extends BaseCubit<FilesState> {
  FilesCubit({required this.filesRepository})
      : super(FilesState.initial()) {
    unawaited(loadFiles());
  }

  final FilesRepository filesRepository;
  final Uuid _uuid = const Uuid();

  Future<void> loadFiles() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      final List<FileModel> files = await filesRepository.getAllFiles();
      emit(state.copyWith(
        files: files,
        status: BaseStateStatus.success,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to load files: $e',
      ));
    }
  }

  Future<void> pickFile() async {
    try {
      final file_picker.FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: file_picker.FileType.custom,
        allowedExtensions: <String>['pdf', 'docx', 'pptx', 'xlsx', 'doc', 'ppt', 'xls'],
      );

      if (result != null && result.files.single.path != null) {
        final file_picker.PlatformFile platformFile = result.files.single;
        final File file = File(platformFile.path!);
        final FileStat stat = await file.stat();

        final FileModel fileModel = FileModel(
          id: _uuid.v4(),
          name: platformFile.name,
          path: platformFile.path!,
          type: _getFileType(platformFile.extension ?? ''),
          size: stat.size,
          dateCreated: stat.modified,
          extension: platformFile.extension,
        );

        // Save to storage
        await filesRepository.saveFile(fileModel);
        
        // Reload files
        await loadFiles();
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to pick file: $e',
      ));
    }
  }

  Future<void> deleteFile(FileModel file) async {
    try {
      await filesRepository.deleteFile(file);
      await loadFiles();
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to delete file: $e',
      ));
    }
  }

  Future<void> openFile(FileModel file) async {
    try {
      await filesRepository.openFile(file);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to open file: $e',
      ));
    }
  }

  String _getFileType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'pdf';
      case 'docx':
      case 'doc':
        return 'docx';
      case 'pptx':
      case 'ppt':
        return 'pptx';
      case 'xlsx':
      case 'xls':
        return 'xlsx';
      default:
        return 'unknown';
    }
  }

  @override
  FilesState getResetErrorState() => state.copyWith(msg: '');

  @override
  FilesState getResetRedirectionState() => state.copyWith();
}

