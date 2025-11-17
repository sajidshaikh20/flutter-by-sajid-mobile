import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../notifier/task_notifier.dart';
import '../notifier/task_state.dart';
import '../repository/task_repository.dart';
import '../repository/task_repository_impl.dart';

/// Provider for TaskRepository.
final Provider<TaskRepository> taskRepositoryProvider = Provider<TaskRepository>((ProviderRef<TaskRepository> ref) {
  return TaskRepositoryImpl();
});

/// Provider for TaskNotifier.
final StateNotifierProvider<TaskNotifier, TaskState> taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, TaskState>((StateNotifierProviderRef<TaskNotifier, TaskState> ref) {
  final TaskRepository repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository: repository);
});

