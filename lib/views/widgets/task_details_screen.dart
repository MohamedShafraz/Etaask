import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;
  final Function onEdit;
  final Function onDelete;

  TaskDetailsScreen({
    required this.title,
    required this.description,
    this.dueDate,
    required this.isCompleted,
    required this.onEdit, // Constructor parameters for callbacks
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              dueDate != null
                  ? 'Due on: ${dueDate!.toLocal().toString().split(' ')[0]}'
                  : 'No Due Date',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              isCompleted ? 'Status: Completed' : 'Status: Not Completed',
              style: TextStyle(
                fontSize: 16,
                color: isCompleted ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            // Add Edit and Delete buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onEdit(); // Trigger the edit callback
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Edit button color
                  ),
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onDelete(); // Trigger the delete callback
                    Navigator.pop(context); // Go back after deleting
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Delete button color
                  ),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
