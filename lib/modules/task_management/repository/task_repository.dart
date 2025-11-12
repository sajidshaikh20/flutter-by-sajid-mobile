import '../../../utils/exports.dart';
import '../model/task_model.dart';

/// Repository interface for task management operations.
abstract class TaskRepository {
  /// Fetches all tasks from local storage.
  Future<List<TaskModel>> getTasks();

  /// Adds a new task.
  Future<void> addTask(TaskModel task);

  /// Updates an existing task.
  Future<void> updateTask(TaskModel task);

  /// Deletes a task by ID.
  Future<void> deleteTask(String taskId);

  /// Toggles the completion status of a task.
  Future<void> toggleTaskCompletion(String taskId);
}




