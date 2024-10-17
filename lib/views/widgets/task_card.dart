import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;

  TaskCard(
      {required this.title,
      required this.description,
      required this.isCompleted}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  description, // Display the task description
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Due on: 29 Sep',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          Text(
            isCompleted ? "Completed" : "Not Completed",
            style: TextStyle(
                color: isCompleted ? Color(0xFF00FF00) : Color(0xFFFFFF00)),
          ),
        ],
      ),
    );
  }
}
