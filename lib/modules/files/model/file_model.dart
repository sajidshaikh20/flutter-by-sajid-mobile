class FileModel {
  const FileModel({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.size,
    required this.dateCreated,
    this.extension,
  });

  final String id;
  final String name;
  final String path;
  final String type; // pdf, docx, pptx, xlsx
  final int size; // in bytes
  final DateTime dateCreated;
  final String? extension;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'path': path,
      'type': type,
      'size': size,
      'dateCreated': dateCreated.toIso8601String(),
      'extension': extension,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      id: map['id'] as String,
      name: map['name'] as String,
      path: map['path'] as String,
      type: map['type'] as String,
      size: map['size'] as int,
      dateCreated: DateTime.parse(map['dateCreated'] as String),
      extension: map['extension'] as String?,
    );
  }

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

