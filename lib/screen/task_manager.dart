import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_task.dart';

class TaskManagerScreen extends StatefulWidget {
  final String userName;
  final String userId;

  const TaskManagerScreen(
      {super.key, required this.userName, required this.userId});

  @override
  TaskManagerScreenState createState() => TaskManagerScreenState();
}

class TaskManagerScreenState extends State<TaskManagerScreen> {
  List<DocumentSnapshot> selectedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: selectedTasks.isEmpty
                ? null
                : () {
                    for (var task in selectedTasks) {
                      FirebaseFirestore.instance
                          .collection('todos')
                          .doc(task.id)
                          .delete();
                    }
                    setState(() {
                      selectedTasks.clear();
                    });
                  },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('todos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Có lỗi xảy ra'));
          }

          final todos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              final task = todo['task'] as String;
              final isDone = todo['isDone'] as bool;
              final Timestamp? updatedOn = todo['updatedOn'] as Timestamp?;

              // Convert Timestamp to readable date and time
              final updatedDate = updatedOn != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                      updatedOn.millisecondsSinceEpoch)
                  : null;

              return ListTile(
                leading: Checkbox(
                  value: isDone,
                  onChanged: (value) {
                    FirebaseFirestore.instance
                        .collection('todos')
                        .doc(todo.id)
                        .update({'isDone': value});
                    setState(() {
                      if (value == true) {
                        selectedTasks.add(todo);
                      } else {
                        selectedTasks.remove(todo);
                      }
                    });
                  },
                ),
                title: Text(
                  task,
                  style: TextStyle(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(
                  updatedDate != null
                      ? "${updatedDate.day}/${updatedDate.month}/${updatedDate.year}, ${updatedDate.hour}:${updatedDate.minute}"
                      : "No date available",
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(userId: widget.userId),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
