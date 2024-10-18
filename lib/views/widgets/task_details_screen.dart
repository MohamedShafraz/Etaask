import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/task.dart';

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
  _TaskDetailsScreenState createState() =>
      _TaskDetailsScreenState(this.taskTitle);
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Future<Task?> _taskFuture;
  final String taskTitle;
  _TaskDetailsScreenState(this.taskTitle);
  @override
  void initState() {
    super.initState();
    _taskFuture = _fetchTaskDetails(widget.taskId);
  }

  Future<Task?> _fetchTaskDetails(int id) async {
    var db = DatabaseHelper();
    return await db.getTaskById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          taskTitle,
          style: TextStyle(
            color: Color(0xFF182c55),
          ),
        ),
        backgroundColor: Colors.white,
      ),
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title:" + task.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Description :" + task.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  task.dueDate != null
                      ? 'Due on: ${task.dueDate!.toLocal().toString().split(' ')[0]}'
                      : 'No Due Date',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  task.isCompleted
                      ? 'Status: Completed'
                      : 'Status: Not Completed',
                  style: TextStyle(
                    fontSize: 16,
                    color: task.isCompleted ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.onEdit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Edit',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.onDelete();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Delete', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
