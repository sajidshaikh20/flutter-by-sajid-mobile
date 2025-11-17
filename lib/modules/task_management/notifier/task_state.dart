import '../../../utils/exports.dart';

/// State class for task management (Riverpod version).
class TaskState {
  /// Creates a [TaskState] instance.
  const TaskState({
    required this.status,
    this.msg,
    this.tasks = const <TaskModel>[],
    this.filterType = TaskFilterType.all,
    this.sortType = TaskSortType.dueDate,
  });

  /// The current state status (e.g., loading, success, failure).
  final BaseStateStatus status;

  /// Optional message, typically used for feedback or error display.
  final String? msg;

  /// List of tasks.
  final List<TaskModel> tasks;

  /// Current filter type.
  final TaskFilterType filterType;

  /// Current sort type.
  final TaskSortType sortType;

  /// Factory method to create an initial state.
  factory TaskState.initial() {
    return const TaskState(
      status: BaseStateStatus.initial,
    );
  }

  /// Creates a copy of the state with updated fields.
  TaskState copyWith({
    BaseStateStatus? status,
    String? msg,
    List<TaskModel>? tasks,
    TaskFilterType? filterType,
    TaskSortType? sortType,
  }) {
    return TaskState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      tasks: tasks ?? this.tasks,
      filterType: filterType ?? this.filterType,
      sortType: sortType ?? this.sortType,
    );
  }

  /// Gets sorted tasks (all tasks shown, no filtering).
  List<TaskModel> get filteredAndSortedTasks {
    List<TaskModel> sorted = List<TaskModel>.from(tasks);

    // Apply sort only (no filtering - show all tasks)
    switch (sortType) {
      case TaskSortType.dueDate:
        sorted.sort((TaskModel a, TaskModel b) => a.dueDate.compareTo(b.dueDate));
      case TaskSortType.title:
        sorted.sort((TaskModel a, TaskModel b) => a.title.compareTo(b.title));
      case TaskSortType.createdDate:
        sorted.sort((TaskModel a, TaskModel b) {
          final DateTime aDate = a.createdAt ?? a.dueDate;
          final DateTime bDate = b.createdAt ?? b.dueDate;
          return bDate.compareTo(aDate); // Newest first
        });
    }

    return sorted;
  }
}

/// Enum for task filter types.
enum TaskFilterType {
  /// Show all tasks.
  all,

  /// Show only completed tasks.
  completed,

  /// Show only pending tasks.
  pending,
}

/// Enum for task sort types.
enum TaskSortType {
  /// Sort by due date.
  dueDate,

  /// Sort by title.
  title,

  /// Sort by creation date.
  createdDate,
}


