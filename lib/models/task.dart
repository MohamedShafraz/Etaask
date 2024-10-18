class Task {
  final int id;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.dueDate,
    this.isCompleted = false,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['title'],
      description: taskMap['description'],
      dueDate: taskMap['dueDate'] != null
          ? DateTime.parse(taskMap['dueDate'])
          : null,
      isCompleted: taskMap['isCompleted'] == 1,
    );
  }

  static Future<List<Task>> fromList(
      List<Map<String, dynamic>> taskList) async {
    return taskList.map((taskMap) => Task.fromMap(taskMap)).toList();
  }
}
