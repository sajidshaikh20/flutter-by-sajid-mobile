import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../notifier/task_state.dart';
import '../repository/task_repository.dart';

/// Notifier for managing task state and operations (Riverpod version).
class TaskNotifier extends StateNotifier<TaskState> {
  /// Creates a [TaskNotifier] instance.
  TaskNotifier({required this.repository})
      : super(TaskState.initial()) {
    unawaited(loadTasks());
  }

  /// Repository for task operations.
  final TaskRepository repository;

  /// Loads all tasks from storage.
  Future<void> loadTasks() async {
    state = state.copyWith(status: BaseStateStatus.loading);
    try {
      final List<TaskModel> tasks = await repository.getTasks();
      state = state.copyWith(
        status: BaseStateStatus.success,
        tasks: tasks,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to load tasks: $e',
      );
    }
  }

  /// Adds a new task.
  Future<void> addTask(TaskModel task) async {
    state = state.copyWith(status: BaseStateStatus.loading);
    try {
      await repository.addTask(task);
      await loadTasks();
    } on Exception catch (e) {
      state = state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to add task: $e',
      );
    }
  }

  /// Updates an existing task.
  Future<void> updateTask(TaskModel task) async {
    state = state.copyWith(status: BaseStateStatus.loading);
    try {
      await repository.updateTask(task);
      await loadTasks();
    } on Exception catch (e) {
      state = state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to update task: $e',
      );
    }
  }

  /// Deletes a task.
  Future<void> deleteTask(String taskId) async {
    state = state.copyWith(status: BaseStateStatus.loading);
    try {
      await repository.deleteTask(taskId);
      await loadTasks();
    } on Exception catch (e) {
      state = state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to delete task: $e',
      );
    }
  }

  /// Toggles task completion status.
  Future<void> toggleTaskCompletion(String taskId) async {
    try {
      await repository.toggleTaskCompletion(taskId);
      await loadTasks();
    } on Exception catch (e) {
      state = state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to toggle task completion: $e',
      );
    }
  }

  /// Sets the filter type.
  void setFilterType(TaskFilterType filterType) {
    state = state.copyWith(filterType: filterType);
  }

  /// Sets the sort type.
  void setSortType(TaskSortType sortType) {
    state = state.copyWith(sortType: sortType);
  }
}


