import 'package:etaask/repository/repository.dart';
import 'package:etaask/services/taskService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

class TaskViewModel extends StateNotifier<AsyncValue<List<Task>>> {
  var _dbHelper = TaskService();

  TaskViewModel() : super(AsyncLoading()) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final List<Map<String, dynamic>> taskMaps = await _dbHelper.getTasks();

      final tasks = taskMaps.map((taskMap) => Task.fromJson(taskMap)).toList();

      state = AsyncData(tasks);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    _loadTasks();
  }

  Future<void> editTask(Task updatedTask) async {
    await _dbHelper.updateTask(updatedTask);
    _loadTasks();
  }

  Future<void> removeTask(int taskId) async {
    await _dbHelper.deleteTask(taskId);
    _loadTasks();
  }
}
