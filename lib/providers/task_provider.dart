import 'package:flutter_riverpod/flutter_riverpod.dart';

class Task {
  final String title;
  final String description;
  bool isCompleted;
  final DateTime? dueDate;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.dueDate,
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
            dueDate: state[i].dueDate,
            isCompleted: !state[i].isCompleted,
          )
        else
          state[i],
    ];
  }

  void removeTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
