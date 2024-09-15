import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth_provider.dart';
import 'package:todo_app/model/Task.dart';
import 'package:todo_app/model/task_collection.dart';
import 'package:todo_app/style/application_style/app_style.dart';
import 'package:todo_app/style/dialogue_utils/dialogue_utils.dart';
import 'package:todo_app/style/reusable_components/custom_form_field.dart';
import 'package:todo_app/todo_provider.dart';

class AddTaskSheet extends StatefulWidget
{
  AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  TextEditingController titleController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context)
  {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add new Task", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppStyle.lightTextColor
              )),
              SizedBox(height: height*0.05),
              CustomFormField(
                  label: "Enter your task",
                  validator: (value){
                    if(value == null || value.isEmpty)
                      {
                        return "The title of the task can't be empty";
                      }
                    return null;
                  },
                  controller: titleController
              ),
              const SizedBox(height: 33),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Date", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppStyle.lightTextColor
                )),
              ),
              InkWell(
                onTap: (){
                  showDateCalendar();
                },
                child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey
                )),
              ),
              SizedBox(height: height*0.05),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  child: const Text("Add"),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom*1.1),
            ],
          ),
        ),
      )
    );
  }

  addTask() async
  {
    // ToDoProvider provider = Provider.of<ToDoProvider>(context, listen: false);
    if(formKey.currentState?.validate()??false)
      {
        DialogueUtils.showLoadingDialogue(context);
        AuthUserProvider authProvider = Provider.of<AuthUserProvider>(context, listen: false);
        await TaskCollection.createTask(
            Task(
                title: titleController.text,
                date: Timestamp.fromMillisecondsSinceEpoch(selectedDate.millisecondsSinceEpoch)
            ),
            authProvider.firebaseUser!.uid
        );
        Navigator.pop(context);
        DialogueUtils.showMessageDialogue(
          context,
          message: "Task is added successfully",
          onPress: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },);
        // provider.refreshTasks(authProvider.firebaseUser!.uid);
      }
  }

  showDateCalendar() async
  {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))
    );
    if(newDate!=null)
      {
        selectedDate = newDate;
        setState(() {

        });
      }
  }
}
