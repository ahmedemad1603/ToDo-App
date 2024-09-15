import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider.dart';
import 'package:todo_app/model/task_collection.dart';
import 'package:todo_app/todo_provider.dart';
import 'package:todo_app/ui/home_screen/widgets/todo_widget.dart';
import '../../../model/Task.dart';

class TasksTab extends StatefulWidget
{
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab>
{
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day
  );

  @override
  Widget build(BuildContext context)
  {
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context);
    //ToDoProvider provider = Provider.of<ToDoProvider>(context);
    // if(provider.isTasksLoading)
    // {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // else if(provider.taskError.isNotEmpty)
    // {
    //   return Center(child: Text(provider.taskError));
    // }
    // else if(provider.tasksList.isEmpty)
    // {
    //   return const Center(child: Text("No Tasks Yet"));
    // }
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.1,
              color: Theme.of(context).colorScheme.primary,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: EasyInfiniteDateTimeLine(
                  firstDate: DateTime.now(),
                  focusDate: selectedDate,
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  dayProps: const EasyDayProps(
                      activeDayStyle: DayStyle(
                          borderRadius: 10,
                          monthStrStyle: TextStyle(color: Colors.transparent)
                      ),
                      todayStyle: DayStyle(
                          monthStrStyle: TextStyle(color: Colors.transparent),
                          decoration: BoxDecoration(
                              color: Colors.white
                          )
                      ),
                      inactiveDayStyle: DayStyle(
                          monthStrStyle: TextStyle(color: Colors.transparent),
                          decoration: BoxDecoration(
                              color: Colors.white
                          )
                      )
                  ),
                  showTimelineHeader: false,
                  onDateChange: (newSelectedDate)
                  {
                    setState(() {
                      selectedDate = DateTime(
                          newSelectedDate.year,
                          newSelectedDate.month,
                          newSelectedDate.day
                      );
                    });
                  }
              ),
            )
          ]
        ),
        Expanded(
          flex: 4,
          child: StreamBuilder(
            stream: TaskCollection.getTaskListen(provider.firebaseUser!.uid, selectedDate),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator());
                }
              else if(snapshot.hasError)
                {
                  return Center(child: Text(snapshot.error!.toString()));
                }
              List<Task> tasks = snapshot.data??[];
              if(tasks.isEmpty)
                {
                  return const Center(child: Text("No Tasks Yet"));
                }
              else
                {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) => ToDoWidget(task: tasks[index]),
                        separatorBuilder: (context, index)
                        {
                          return const SizedBox(height: 20,);
                        },
                        itemCount: tasks.length),
                  );
                }
            },
          ),
        )
      ]
    );
  }
}