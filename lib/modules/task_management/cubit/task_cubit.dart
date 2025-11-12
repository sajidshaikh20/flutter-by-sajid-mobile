import '../../../utils/exports.dart';

/// Cubit for managing task state and operations.
class TaskCubit extends BaseCubit<TaskState> {
  /// Creates a [TaskCubit] instance.
  TaskCubit({required this.repository})
      : super(TaskState.initial()) {
    unawaited(loadTasks());
  }

  /// Repository for task operations.
  final TaskRepository repository;

  /// Loads all tasks from storage.
  Future<void> loadTasks() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      final List<TaskModel> tasks = await repository.getTasks();
      emit(state.copyWith(
        status: BaseStateStatus.success,
        tasks: tasks,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to load tasks: $e',
      ));
    }
  }

  /// Adds a new task.
  Future<void> addTask(TaskModel task) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      await repository.addTask(task);
      await loadTasks();
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to add task: $e',
      ));
    }
  }

  /// Updates an existing task.
  Future<void> updateTask(TaskModel task) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      await repository.updateTask(task);
      await loadTasks();
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to update task: $e',
      ));
    }
  }

  /// Deletes a task.
  Future<void> deleteTask(String taskId) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      await repository.deleteTask(taskId);
      await loadTasks();
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to delete task: $e',
      ));
    }
  }

  /// Toggles task completion status.
  Future<void> toggleTaskCompletion(String taskId) async {
    try {
      await repository.toggleTaskCompletion(taskId);
      await loadTasks();
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to toggle task completion: $e',
      ));
    }
  }

  /// Sets the filter type.
  void setFilterType(TaskFilterType filterType) {
    emit(state.copyWith(filterType: filterType));
  }

  /// Sets the sort type.
  void setSortType(TaskSortType sortType) {
    emit(state.copyWith(sortType: sortType));
  }

  @override
  TaskState getResetErrorState() => state.copyWith(msg: '');

  @override
  TaskState getResetRedirectionState() => state.copyWith();
}

