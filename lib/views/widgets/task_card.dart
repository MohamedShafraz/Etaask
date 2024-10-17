import 'package:etaask/models/task.dart';
import 'package:etaask/views/widgets/edit_task_dialog.dart';
import 'package:flutter/material.dart';
import '../../providers/task_provider.dart';
import 'task_details_screen.dart';

void _showEditTaskDialog(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (context) {
      try {
        return EditTaskDialog(
          taskId: task.id,
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          isCompleted: task.isCompleted,
        );
      } catch (err) {
        return Text(err.toString());
      }
    },
  );
}

class TaskCard extends StatelessWidget {
  final int taskId;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;

  TaskCard({
    required this.taskId,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsScreen(
              title: title,
              description: description,
              dueDate: dueDate,
              isCompleted: isCompleted,
              onEdit: () {
                _showEditTaskDialog(
                    context,
                    Task(
                        id: taskId,
                        title: title,
                        description: description,
                        dueDate: dueDate,
                        isCompleted: isCompleted));
              },
              onDelete: () {},
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Color(0xFFB0D4F1),
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
                    title,
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
