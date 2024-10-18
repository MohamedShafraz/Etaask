import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../database/database_helper.dart';
import '../../models/task.dart';
import 'edit_task_dialog.dart';

class TaskDetailsScreen extends StatefulWidget {
  final int taskId;
  final String taskTitle;
  final Function onEdit;
  final Function onDelete;

  TaskDetailsScreen({
    required this.taskId,
    required this.taskTitle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Future<Task?> _taskFuture;

  @override
  void initState() {
    super.initState();
    _taskFuture = _fetchTaskDetails(widget.taskId);
  }

  Future<Task?> _fetchTaskDetails(int id) async {
    var db = DatabaseHelper();
    return await db.getTaskById(id);
  }

  void _refreshTaskDetails() {
    setState(() {
      _taskFuture = _fetchTaskDetails(widget.taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF182C55),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white, // Set your desired color for the back button
        ),
      ),
      backgroundColor: Color(0xFFF6F7FB),
      body: FutureBuilder<Task?>(
        future: _taskFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No task found'));
          }

          final task = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF182C55),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Color(0xFF182C55)),
                        SizedBox(width: 8.0),
                        Text(
                          task.dueDate != null
                              ? 'Due on: ${DateFormat('EEE, MMM d, yyyy').format(task.dueDate!)}'
                              : 'No Due Date',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(
                          task.isCompleted ? Icons.check_circle : Icons.error,
                          color: task.isCompleted ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          task.isCompleted
                              ? 'Status: Completed'
                              : 'Status: Not Completed',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: task.isCompleted ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditTaskDialog(
                                  taskId: task.id!,
                                  title: task.title,
                                  description: task.description,
                                  dueDate: task.dueDate,
                                  isCompleted: task.isCompleted,
                                  onUpdate: (updatedTask) {
                                    _refreshTaskDetails();
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit, color: Colors.white),
                          label: Text('Edit',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF182C55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            widget.onDelete();
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.delete, color: Colors.white),
                          label: Text('Delete',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
