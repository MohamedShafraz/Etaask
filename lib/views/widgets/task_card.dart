import 'package:flutter/material.dart';
import 'task_details_screen.dart'; // Import the details screen

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;

  TaskCard({
    required this.title,
    required this.description,
    required this.isCompleted,
    this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the TaskDetailsScreen with the edit and delete callbacks
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsScreen(
              title: title,
              description: description,
              dueDate: dueDate,
              isCompleted: isCompleted,
              onEdit: () {
                // Define what happens when the user presses "Edit"
                print("Edit Task: $title");
                // You can navigate to an edit form or show a modal here.
              },
              onDelete: () {
                // Define what happens when the user presses "Delete"
                print("Delete Task: $title");
                // You can remove the task.dart from your list here.
              },
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Color(0xFFB0D4F1), // Light blue background color
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, // Display the task title
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    dueDate != null
                        ? 'Due on: ${dueDate!.toLocal().toString().split(' ')[0]}'
                        : 'No Due Date',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : Colors.yellow,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                isCompleted ? "Completed" : "Not Completed",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
