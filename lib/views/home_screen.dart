import '../views/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../views/widgets/create_task_dialog.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    final completedTasks = tasks.where((task) => task.isCompleted).toList();
    final incompleteTasks = tasks.where((task) => !task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'eTaask',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF182c55),
      ),
      body: Column(
        children: [
          if (tasks.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No tasks available!',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Click the button below to add a new task.',
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView(
                children: [
                  if (completedTasks.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF182c55),
                        ),
                      ),
                    ),
                    ...completedTasks
                        .map((task) => TaskCard(task: task))
                        .toList(),
                  ],
                  if (incompleteTasks.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        'Incomplete Tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF182c55),
                        ),
                      ),
                    ),
                    ...incompleteTasks
                        .map((task) => TaskCard(task: task))
                        .toList(),
                  ]
                ],
              ),
            ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                primary: Color(0xFF182c54),
              ),
              onPressed: () => _showCreateTaskDialog(context, ref),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateTaskDialog(ref: ref);
      },
    );
  }
}
