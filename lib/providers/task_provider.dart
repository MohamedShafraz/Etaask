import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/task_view_model.dart';
import '../models/task.dart' as Task;

final taskProvider =
    StateNotifierProvider<TaskViewModel, List<Task.Task>>((ref) {
  return TaskViewModel();
});
