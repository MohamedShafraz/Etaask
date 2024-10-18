import '../../database/database_helper.dart';
import '../../models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
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
  final _formKey = GlobalKey<FormState>(); // Form key for validation

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

  int _generateTaskId() {
    final random = Random();
    return random.nextInt(100000);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Task title cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Task description cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDueDate == null
                          ? 'Due Date:'
                          : 'Due Date: ${_selectedDueDate!.toLocal()}'
                              .split(' ')[0],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDueDate(context),
                    child: _selectedDueDate == null
                        ? Text('Select Due Date')
                        : Text('${_selectedDueDate!.toLocal()}'
                            .split(' ')[0]
                            .toString()),
                  ),
                ],
              ),
            ],
          ),
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
          onPressed: () async {
            // Validate form only when the Create button is clicked
            if (_formKey.currentState!.validate()) {
              // Check if due date is not selected
              if (_selectedDueDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a due date')),
                );
                return; // Prevent further action if due date is not selected
              }

              String taskTitle = titleController.text.trim();
              String taskDescription = descriptionController.text.trim();

              // Generate task ID
              int taskId = _generateTaskId();

              Task newTask = Task(
                id: taskId, // Explicitly set to null for auto-increment
                title: taskTitle,
                description: taskDescription,
                dueDate: _selectedDueDate, // Ensure correct conversion
                isCompleted: false,
              );

              DatabaseHelper dbHelper = DatabaseHelper();

              await dbHelper.insertTask(newTask); // Await the insert operation
              widget.ref.read(taskProvider.notifier).addTask(newTask);

              Navigator.of(context)
                  .pop(); // Close the dialog after creating the task
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
