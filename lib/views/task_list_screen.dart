import 'package:flutter/material.dart';
import '../helper/database_helper.dart'; // Import the database helper

class TaskDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  TaskDetailsScreen({
    required this.title,
    required this.description,
    this.dueDate,
    required this.isCompleted,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Details',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Show a confirmation dialog before deleting the task
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Delete Task"),
                  content:
                      Text("Are you sure you want to delete this task.dart?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        onDelete(); // Trigger the delete functionality
                        Navigator.pop(context); // Close the dialog
                        Navigator.pop(context); // Go back to task list
                      },
                      child: Text("Delete"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Just close the dialog
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              dueDate != null
                  ? 'Due Date: ${dueDate!.toLocal().toString().split(' ')[0]}'
                  : 'No Due Date',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              isCompleted ? 'Status: Completed' : 'Status: Not Completed',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
