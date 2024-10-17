import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../models/task.dart';
import '../../providers/task_provider.dart';

class CreateTaskDialog extends StatefulWidget {
  final WidgetRef ref;

  CreateTaskDialog({required this.ref});

  @override
  _CreateTaskDialogState createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? _selectedDueDate;

  // Method to show the date picker dialog
  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  // Method to generate a unique ID for each task
  int _generateTaskId() {
    final random = Random();
    return random.nextInt(100000); // Generates a random number as task ID
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDueDate == null
                        ? 'No Due Date Selected'
                        : 'Due Date: ${_selectedDueDate!.toLocal()}'
                            .split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDueDate(context),
                  child: Text('Select Due Date'),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String taskTitle = titleController.text;
            String taskDescription = descriptionController.text;

            // Generate a new task ID
            int taskId = _generateTaskId();

            // Add the new task using the task provider
            widget.ref.read(taskProvider.notifier).addTask(
                  Task(
                    id: taskId,
                    title: taskTitle,
                    description: taskDescription,
                    dueDate: _selectedDueDate,
                    isCompleted: false,
                  ),
                );

            Navigator.of(context)
                .pop(); // Close the dialog after creating the task
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
