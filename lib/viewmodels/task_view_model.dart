import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

class TaskViewModel extends StateNotifier<List<Task>> {
  TaskViewModel() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void editTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
  }

  void removeTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
  }
}
