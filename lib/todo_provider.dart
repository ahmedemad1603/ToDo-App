import 'package:flutter/material.dart';
import 'model/Task.dart';
import 'model/task_collection.dart';

class ToDoProvider extends ChangeNotifier
{
  List<Task> tasksList = [];
  bool isTasksLoading = false;
  String taskError = "";
  refreshTasks(String uid) async
  {
    try{
      isTasksLoading = true;
      notifyListeners();
      tasksList = await TaskCollection.getTasks(uid);
      taskError = "";
      isTasksLoading = false;
      notifyListeners();
    }
    catch(error){
      taskError = error.toString();
      isTasksLoading = false;
      notifyListeners();
    }
  }
}