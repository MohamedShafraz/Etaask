import '../../services/taskService.dart';
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
  String? _dueDateError;
  var _taskService = TaskService();
  final _formKey = GlobalKey<FormState>();

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
        _dueDateError = null;
      });
    }
  }

  int _generateTaskId() {
    final random = Random();
    return random.nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Create New Task',
        style: TextStyle(
          color: Color(0xff182c55),
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  labelStyle: TextStyle(color: Color(0xff182c55)),
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
                  labelStyle: TextStyle(color: Color(0xff182c55)),
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
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff182c55),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDueDate(context),
                    child: _selectedDueDate == null
                        ? Text('Select Due Date')
                        : Text('${_selectedDueDate!.toLocal()}'.split(' ')[0]),
                    style: TextButton.styleFrom(
                      primary: Color(0xff182c55),
                    ),
                  ),
                ],
              ),
              if (_dueDateError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    _dueDateError!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(0xff182c55)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF182c55),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (_selectedDueDate == null) {
                setState(() {
                  _dueDateError = 'Please select a due date';
                });
                return;
              }

              String taskTitle = titleController.text.trim();
              String taskDescription = descriptionController.text.trim();

              int taskId = _generateTaskId();

              Task newTask = Task(
                id: taskId,
                title: taskTitle,
                description: taskDescription,
                dueDate: _selectedDueDate,
                isCompleted: false,
              );

              // DatabaseHelper dbHelper = DatabaseHelper();
              //
              // await dbHelper.insertTask(newTask);
              // var result = await _taskService.insertTask(newTask);
              widget.ref.read(taskProvider.notifier).addTask(newTask);

              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Create',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
