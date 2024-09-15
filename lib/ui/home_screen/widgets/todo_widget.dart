import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider.dart';
import 'package:todo_app/model/task_collection.dart';
import 'package:todo_app/style/dialogue_utils/dialogue_utils.dart';

import '../../../model/Task.dart';
import '../../../todo_provider.dart';

class ToDoWidget extends StatefulWidget
{
  Task task;

  ToDoWidget({super.key, required this.task});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context)
  {
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
              onPressed: (context) {
                deleteTask();
              },
              icon: Icons.delete,
              label: "Delete",
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20)
              )
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 27,
          horizontal: 17
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              const SizedBox(width: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title??"", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 2),
                      Text("${widget.task.date?.toDate().hour??"null"}:${widget.task.date?.toDate().minute??"null"}")
                    ],
                  )
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: (){

                  },
                  child: const Icon(Icons.check)
              )
            ],
          ),
        ),

      ),
    );
  }

  deleteTask()
  {
    ToDoProvider toDoProvider = Provider.of<ToDoProvider>(context, listen: false);
    var provider = Provider.of<AuthUserProvider>(context, listen: false);
    DialogueUtils.showConfirmationDialogue(
        context,
        message: "Are you sure you want to delete the task?",
        onPositivePress: () async {
          Navigator.pop(context);
          DialogueUtils.showLoadingDialogue(context);
          await TaskCollection.deleteTask(provider.firebaseUser!.uid, widget.task.id??"");
          Navigator.pop(context);
          toDoProvider.refreshTasks(provider.firebaseUser!.uid);
        },
        onNegativePress: (){
          Navigator.pop(context);
        }
    );
    TaskCollection.deleteTask(
        provider.firebaseUser!.uid,
        widget.task.id??""
    );
  }
}
