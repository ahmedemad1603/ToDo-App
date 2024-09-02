import 'package:flutter/material.dart';
import 'package:todo_app/ui/home_screen/widgets/todo_widget.dart';

class TasksTab extends StatelessWidget
{
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => ToDoWidget(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20);
          },
          itemCount: 3,
      ),
    );
  }
}
