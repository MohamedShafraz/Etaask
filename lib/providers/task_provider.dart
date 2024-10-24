import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/task_view_model.dart';
import '../models/task.dart';

final taskProvider =
    StateNotifierProvider<TaskViewModel, AsyncValue<List<Task>>>((ref) {
  return TaskViewModel();
});
