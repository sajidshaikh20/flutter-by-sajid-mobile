import '../../../utils/exports.dart';
import '../model/file_model.dart';

class FilesState extends BaseState {
  const FilesState({
    required super.status,
    super.redirectRoute,
    super.msg,
    this.files = const <FileModel>[],
  });

  final List<FileModel> files;

  FilesState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    List<FileModel>? files,
  }) {
    return FilesState(
      status: status ?? this.status,
      redirectRoute: redirectRoute ?? this.redirectRoute,
      msg: msg ?? this.msg,
      files: files ?? this.files,
    );
  }

  static FilesState initial() {
    return const FilesState(
      status: BaseStateStatus.initial,
      files: <FileModel>[],
    );
  }
}

