import 'package:flutter_riverpod/flutter_riverpod.dart';

class Task {
  final String title;
  final String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void toggleTaskCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(
            title: state[i].title,
            description: state[i].description,
            isCompleted: !state[i].isCompleted,
          )
        else
          state[i],
    ];
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
