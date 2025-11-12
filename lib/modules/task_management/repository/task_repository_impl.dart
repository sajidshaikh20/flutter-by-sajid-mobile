import '../../../utils/exports.dart';

/// Implementation of [TaskRepository] using GetStorage for local persistence.
class TaskRepositoryImpl implements TaskRepository {
  /// Storage key for tasks.
  static const String _tasksKey = 'tasks_storage_key';

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final String tasksJson = SharedPref.instance.getString(_tasksKey, '');
      if (tasksJson.isEmpty) {
        return <TaskModel>[];
      }

      final List<dynamic> tasksList = jsonDecode(tasksJson) as List<dynamic>;
      return tasksList
          .map((dynamic json) => TaskModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on Exception catch (e) {
      DebugLog.instance.e('Error loading tasks: $e');
      return <TaskModel>[];
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      final List<TaskModel> tasks = await getTasks();
      tasks.add(task);
      await _saveTasks(tasks);
    } on Exception catch (e) {
      DebugLog.instance.e('Error adding task: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      final List<TaskModel> tasks = await getTasks();
      final int index = tasks.indexWhere((TaskModel t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task;
        await _saveTasks(tasks);
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating task: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      final List<TaskModel> tasks = await getTasks();
      tasks.removeWhere((TaskModel task) => task.id == taskId);
      await _saveTasks(tasks);
    } on Exception catch (e) {
      DebugLog.instance.e('Error deleting task: $e');
      rethrow;
    }
  }

  @override
  Future<void> toggleTaskCompletion(String taskId) async {
    try {
      final List<TaskModel> tasks = await getTasks();
      final int index = tasks.indexWhere((TaskModel t) => t.id == taskId);
      if (index != -1) {
        tasks[index] = tasks[index].copyWith(
          isCompleted: !tasks[index].isCompleted,
        );
        await _saveTasks(tasks);
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error toggling task completion: $e');
      rethrow;
    }
  }

  /// Saves tasks to local storage.
  Future<void> _saveTasks(List<TaskModel> tasks) async {
    final String tasksJson = jsonEncode(
      tasks.map((TaskModel task) => task.toJson()).toList(),
    );
    await SharedPref.instance.setValue(_tasksKey, tasksJson);
  }
}

