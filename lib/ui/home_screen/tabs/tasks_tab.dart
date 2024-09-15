import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider.dart';
import 'package:todo_app/model/task_collection.dart';
import 'package:todo_app/todo_provider.dart';
import 'package:todo_app/ui/home_screen/widgets/todo_widget.dart';
import '../../../model/Task.dart';

class TasksTab extends StatelessWidget
{
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context)
  {
    ToDoProvider provider = Provider.of<ToDoProvider>(context);
    if(provider.isTasksLoading)
    {
      return const Center(child: CircularProgressIndicator());
    }
    else if(provider.taskError.isNotEmpty)
    {
      return Center(child: Text(provider.taskError));
    }
    else if(provider.tasksList.isEmpty)
    {
      return const Center(child: Text("No Tasks Yet"));
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
          itemBuilder: (context, index) => ToDoWidget(task: provider.tasksList[index]),
          separatorBuilder: (context, index)
          {
            return const SizedBox(height: 20,);
          },
          itemCount: provider.tasksList.length)
    );
  }
}