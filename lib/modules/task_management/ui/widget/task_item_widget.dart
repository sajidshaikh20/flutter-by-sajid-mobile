import '../../../../utils/exports.dart';

/// Widget for displaying a single task item in the list.
class TaskItemWidget extends StatelessWidget {
  /// Creates a [TaskItemWidget].
  const TaskItemWidget({
    required this.task,
    required this.onTap,
    required this.onToggleComplete,
    required this.onDelete,
    super.key,
  });

  /// The task to display.
  final TaskModel task;

  /// Callback when the task is tapped.
  final VoidCallback onTap;

  /// Callback when the completion status is toggled.
  final Future<void> Function()? onToggleComplete;

  /// Callback when the task is deleted.
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final bool isOverdue =
        !task.isCompleted && task.dueDate.isBefore(DateTime.now());
    final Color statusColor = task.isCompleted ? Colors.green : Colors.amber;
    final Color cardColor =
        task.isCompleted ? Colors.green.shade50 : Colors.amber.shade50;

    return Card(
      margin: const EdgeInsets.only(bottom: Dimens.space12),
      elevation: Dimens.elevation2,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radius12),
        side: BorderSide(
          color: statusColor,
          width: Dimens.size2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: Dimens.size12,
                    height: Dimens.size12,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: Dimens.size8),
                  Expanded(
                    child: CustomTextLabelWidget(
                      label: task.isCompleted ? 'Completed' : 'Pending',
                      style: TextStyle(
                        fontSize: Dimens.fontSize12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: onDelete,
                    tooltip: 'Delete task',
                  ),
                ],
              ),
              const SizedBox(height: Dimens.space12),
              CustomTextLabelWidget(
                label: task.title,
                style: TextStyle(
                  fontSize: Dimens.fontSize18,
                  fontWeight: FontWeight.bold,
                  color: task.isCompleted ? Colors.grey[700] : Colors.black87,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: Dimens.size8),
              CustomTextLabelWidget(
                label: task.description,
                style: TextStyle(
                  fontSize: Dimens.fontSize14,
                  color: task.isCompleted ? Colors.grey[600] : Colors.grey[700],
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
                maxLines: Dimens.maxLines02,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: Dimens.space12),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    size: Dimens.size14,
                    color: isOverdue ? Colors.red : Colors.grey[600],
                  ),
                  const SizedBox(width: Dimens.size4),
                  CustomTextLabelWidget(
                    label: DateFormat('MMM dd, yyyy • hh:mm a')
                        .format(task.dueDate),
                    style: TextStyle(
                      fontSize: Dimens.fontSize12,
                      color: isOverdue ? Colors.red : Colors.grey[600],
                      fontWeight:
                          isOverdue ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  if (isOverdue) ...<Widget>[
                    const SizedBox(width: Dimens.size8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space6,
                        vertical: Dimens.space2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(Dimens.radius4),
                      ),
                      child: const CustomTextLabelWidget(
                        label: 'OVERDUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimens.fontSize10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: Dimens.space12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (task.isCompleted)
                    ElevatedButton.icon(
                      onPressed: () => onToggleComplete?.call(),
                      icon: const Icon(Icons.refresh, size: Dimens.size16),
                      label: const CustomTextLabelWidget(
                        label: 'Pending',
                        style: TextStyle(fontSize: Dimens.fontSize12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space12,
                          vertical: Dimens.size8,
                        ),
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: () => onToggleComplete?.call(),
                      icon: const Icon(Icons.check_circle, size: Dimens.size16),
                      label: const CustomTextLabelWidget(
                        label: 'Complete',
                        style: TextStyle(fontSize: Dimens.fontSize12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space12,
                          vertical: Dimens.size8,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
