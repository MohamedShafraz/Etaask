import 'package:etaask/views/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:etaask/providers/task_provider.dart';
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
        backgroundColor: Color(0xFF182c54),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskCard(
                  taskId: task.id,
                  title: task.title,
                  description: task.description,
                  isCompleted: task.isCompleted,
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(
                  15), // Adjust padding to control the button size
            ),
            onHover: (value) {},
            onPressed: () => _showCreateTaskDialog(context, ref),
            child: Icon(
              Icons.add, // Change icon color on hover
            ),
          ),
          SizedBox(
            height: 10,
          ),
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
