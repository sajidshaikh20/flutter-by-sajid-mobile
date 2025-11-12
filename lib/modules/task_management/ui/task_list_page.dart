import '../../../utils/exports.dart';


@RoutePage()
/// Main page displaying the list of tasks.
class TaskListPage extends StatelessWidget {
  /// Creates a [TaskListPage].
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (BuildContext context) => TaskCubit(
        repository: TaskRepositoryImpl(),
      ),
      child: const TaskListView(),
    );
  }
}

/// View widget for the task list.
class TaskListView extends StatelessWidget {
  /// Creates a [TaskListView].
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const CustomTextLabelWidget(
          label: 'Task Management',
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: Colors.black),
            onSelected: (String value) {
              final TaskCubit cubit = context.read<TaskCubit>();
              switch (value) {
                case 'sort_due_date':
                  cubit.setSortType(TaskSortType.dueDate);
                case 'sort_title':
                  cubit.setSortType(TaskSortType.title);
                case 'sort_created':
                  cubit.setSortType(TaskSortType.createdDate);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'sort_due_date',
                child: CustomTextLabelWidget(
                  label: 'Due Date',
                  textAlign: TextAlign.start,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'sort_title',
                child: CustomTextLabelWidget(
                  label: 'Title',
                  textAlign: TextAlign.start,
                ),
              ),
              const PopupMenuItem<String>(
                value: 'sort_created',
                child: CustomTextLabelWidget(
                  label: 'Created',
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (BuildContext context, TaskState state) {
          if (state.status == BaseStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.task_alt,
                    size: Dimens.size64,
                    color: Colors.grey[400],
                  ),
                 const SizedBox(height: Dimens.size16),
                  CustomTextLabelWidget(
                    label: 'No tasks found',
                    style: TextStyle(
                      fontSize: Dimens.fontSize18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              const    SizedBox(height: Dimens.size8),
                  CustomTextLabelWidget(
                    label: 'Tap the + button to add a new task',
                    style: TextStyle(
                      fontSize: Dimens.fontSize14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              Dimens.size16,
              Dimens.size16,
              Dimens.size16,
              Dimens.size150,
            ),
            itemCount: state.filteredAndSortedTasks.length,
            itemBuilder: (BuildContext context, int index) {
              final TaskModel task = state.filteredAndSortedTasks[index];
              return TaskItemWidget(
                task: task,
                onTap: () async {
                  final Object? result = await context.router.push(
                    TaskFormRoute(task: task),
                  );
                  if (context.mounted && result == true) {
                    await context.read<TaskCubit>().loadTasks();
                  }
                },
                onToggleComplete: () async {
                  if (!task.isCompleted) {
                    await _showCompleteConfirmationDialog(context, task.id);
                  } else {
                    await context.read<TaskCubit>().toggleTaskCompletion(task.id);
                  }
                },
                onDelete: () async {
                  await _showDeleteDialog(context, task.id);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () async {
          final Object? result = await context.router.push(TaskFormRoute());
          if (context.mounted && result == true) {
            await context.read<TaskCubit>().loadTasks();
          }
        },
        icon: const Icon(Icons.add),
        label: const CustomTextLabelWidget(
          label: 'Add Task',
        ),
      ),
    );
  }

  /// Shows a confirmation dialog before completing a task.
  Future<void> _showCompleteConfirmationDialog(BuildContext context, String taskId) async {
    final TaskCubit taskCubit = context.read<TaskCubit>();
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const CustomTextLabelWidget(
          label: 'Complete Task',
          textAlign: TextAlign.start,
        ),
        content: const CustomTextLabelWidget(
          label: 'Are you sure you want to complete the task?',
          textAlign: TextAlign.start,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const CustomTextLabelWidget(
              label: 'Cancel',
            ),
          ),
          TextButton(
            onPressed: () {
              unawaited(taskCubit.toggleTaskCompletion(taskId));
              Navigator.of(dialogContext).pop();
            },
            child: const CustomTextLabelWidget(
              label: 'Complete',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a confirmation dialog before deleting a task.
  Future<void> _showDeleteDialog(BuildContext context, String taskId) async {
    final TaskCubit taskCubit = context.read<TaskCubit>();
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const CustomTextLabelWidget(
          label: 'Delete Task',
          textAlign: TextAlign.start,
        ),
        content: const CustomTextLabelWidget(
          label: 'Are you sure you want to delete this task?',
          textAlign: TextAlign.start,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const CustomTextLabelWidget(
              label: 'Cancel',
            ),
          ),
          TextButton(
            onPressed: () {
              unawaited(taskCubit.deleteTask(taskId));
              Navigator.of(dialogContext).pop();
            },
            child: const CustomTextLabelWidget(
              label: 'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

