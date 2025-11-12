import '../../../utils/exports.dart';

/// State class for task management.
class TaskState extends BaseState {
  /// Creates a [TaskState] instance.
  const TaskState({
    required super.status,
    super.msg,
    super.redirectRoute,
    this.tasks = const <TaskModel>[],
    this.filterType = TaskFilterType.all,
    this.sortType = TaskSortType.dueDate,
  });

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
    PageRouteInfo? redirectRoute,
    List<TaskModel>? tasks,
    TaskFilterType? filterType,
    TaskSortType? sortType,
  }) {
    return TaskState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
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

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        tasks,
        filterType,
        sortType,
      ];
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

