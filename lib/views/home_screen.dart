import 'package:etaask/views/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:etaask/providers/task_provider.dart';
import 'package:etaask/models/task.dart';
import 'package:etaask/views/widgets/create_task_dialog.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

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
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    task: Task(
                      id: task.id,
                      title: task.title,
                      description: task.description,
                      dueDate: task.dueDate,
                      isCompleted: task.isCompleted,
                    ),
                  );
                },
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
