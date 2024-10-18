import '../../database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/task.dart';
import '../../views/widgets/edit_task_dialog.dart';
import '../widgets/task_details_screen.dart';
import '../../providers/task_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void _showEditTaskDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (context) {
      return EditTaskDialog(
        taskId: task.id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        isCompleted: task.isCompleted,
      );
    },
  );
}

class TaskCard extends ConsumerWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      elevation: 5,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          task.dueDate != null
              ? 'Due on: ${DateFormat('yMd').format(task.dueDate!)}'
              : 'No Due Date',
          style: TextStyle(color: Colors.black54),
        ),
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showEditTaskDialog(context, task),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Confirm deletion
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete Task'),
                      content:
                          Text('Are you sure you want to delete this task?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            DatabaseHelper dbHelper = DatabaseHelper();
                            dbHelper.deleteTask(task.id);
                            ref.read(taskProvider.notifier).removeTask(task.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Task deleted successfully')),
                            );
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                taskId: task.id,
                onEdit: () => _showEditTaskDialog(context, task),
                onDelete: () {
                  DatabaseHelper dbHelper = DatabaseHelper();
                  dbHelper.deleteTask(task.id);
                  ref.read(taskProvider.notifier).removeTask(task.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task deleted successfully')),
                  );
                  Navigator.of(context).pop(); // Close the details screen
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
