import '../../../../utils/exports.dart';
import '../../model/file_model.dart';

class FileListItem extends StatelessWidget {
  const FileListItem({
    super.key,
    required this.file,
    required this.onTap,
    required this.onDelete,
  });

  final FileModel file;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  IconData _getFileIcon() {
    switch (file.type) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'docx':
        return Icons.description;
      case 'pptx':
        return Icons.slideshow;
      case 'xlsx':
        return Icons.table_chart;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileColor() {
    switch (file.type) {
      case 'pdf':
        return Colors.red;
      case 'docx':
        return Colors.blue;
      case 'pptx':
        return Colors.orange;
      case 'xlsx':
        return Colors.green;
      default:
        return MainConfig.appColors.greyTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space8,
      ),
      child: ListTile(
        leading: Icon(
          _getFileIcon(),
          color: _getFileColor(),
          size: Dimens.size32,
        ),
        title: Text(
          file.name,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: Dimens.space4),
            Text(
              file.formattedSize,
              style: context.textTheme.bodySmall,
            ),
            Text(
              DateFormat('MMM dd, yyyy • HH:mm').format(file.dateCreated),
              style: context.textTheme.bodySmall?.copyWith(
                color: MainConfig.appColors.greyTextColor,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.red,
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}

