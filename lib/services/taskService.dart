import '../repository/repository.dart';
import '../models/task.dart';

class TaskService {
  late TaskRepository _taskRepository;
  TaskService() {
    _taskRepository = TaskRepository();
  }

  getTasks() async {
    return await _taskRepository.readData('tasks');
  }

  Future<Task> getTaskById(int id) async {
    var result = await _taskRepository.readDataById('tasks', id);
    var resultmap = Task.fromMap(result.first);
    return resultmap;
  }

  insertTask(Task task) async {
    return await _taskRepository.insertData("tasks", task.toMap());
  }

  updateTask(Task task) async {
    return await _taskRepository.updateData('tasks', task.toMap());
  }

  deleteTask(int id) async {
    return await _taskRepository.deleteData('tasks', id);
  }
}
