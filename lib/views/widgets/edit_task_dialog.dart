import '../../database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import '../../providers/task_provider.dart';

class EditTaskDialog extends ConsumerStatefulWidget {
  final int taskId;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;
  final Function(Task) onUpdate; // New callback function to pass updated task

  EditTaskDialog({
    required this.taskId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.onUpdate,
  });

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends ConsumerState<EditTaskDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    _selectedDueDate = widget.dueDate;
    _isCompleted = widget.isCompleted;
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mark as Completed',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            String taskTitle = titleController.text.trim();
            String taskDescription = descriptionController.text.trim();

            if (taskTitle.isEmpty || taskDescription.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Title and Description cannot be empty'),
                ),
              );
              return;
            }

            Task updatedTask = Task(
              id: widget.taskId,
              title: taskTitle,
              description: taskDescription,
              dueDate: _selectedDueDate,
              isCompleted: _isCompleted,
            );

            DatabaseHelper dbHelper = DatabaseHelper();
            await dbHelper.updateTask(updatedTask);

            ref.read(taskProvider.notifier).editTask(updatedTask);

            widget.onUpdate(
                updatedTask); // Pass updated task back to parent screen

            Navigator.of(context).pop();
          },
          child: Text('Edit'),
        ),
      ],
    );
  }
}
