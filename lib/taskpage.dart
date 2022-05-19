import 'package:flutter/material.dart';
import 'model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app_flutter/screens/completedtaskpage.dart';
import '../boxes.dart';
import 'widgets.dart';

class TaskPage extends StatefulWidget {


  const TaskPage({Key key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();

}

class _TaskPageState extends State<TaskPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Peliculas por ver'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  CompletedTaskPage())),
                icon: const Icon(Icons.arrow_forward))
          ],
        ),
        body: ValueListenableBuilder<Box<Task>>(
          valueListenable: Boxes.getTasks().listenable(),
          builder: (context, box, _) {
            final tasks = box.values.toList().cast<Task>();
            final unfinishedTasks = tasks.where((task) => !task.isCompleted);

            return ListView(
              children: unfinishedTasks.map((task) => TaskCardWidget(task: task)).toList(),
            );
          },
        ),
        floatingActionButton: NewTaskModalWidget()
    );
  }
}