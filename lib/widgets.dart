import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'boxes.dart';
import 'model/task.dart';

class TaskCardWidget extends StatelessWidget {
  TaskCardWidget({
    Key key,
    this.task
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(task.titulo),
              subtitle: Text(task.sinopsis),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                EditTaskModalWidget(task: task,),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Borrar'),
                  onPressed: () => deleteTask(task),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => taskCompleted(task),
                  child: const Text("vista"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask(Task task) {
    task.delete();
  }

  void taskCompleted(Task task) {
    task.isCompleted = true;

    task.save();
  }
}
class CompletedTaskWidget extends StatelessWidget {
  const CompletedTaskWidget({
    Key key,
    this.task
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(task.titulo),
              subtitle: Text(task.sinopsis),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => deleteTask(task),
                  child: const Text("remover"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask(Task task) {
    task.delete();
  }
}


class NewTaskModalWidget extends StatelessWidget {
  NewTaskModalWidget({Key key}) : super(key: key);

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children:  <Widget>[
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            decoration: const InputDecoration(
                              hintText: "Titulo",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskTitleController,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Sinopsis",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskDescriptionController,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () => {
                                taskTitleController.text = "",
                                taskDescriptionController.text = "",
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Nueva pélicula por ver'),
                              onPressed: () => {
                                addTask(taskTitleController.text, taskDescriptionController.text),
                                taskTitleController.text = "",
                                taskDescriptionController.text = "",
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addTask(String title, String description) {
    final task = Task()
      ..titulo = title == "" ? "(Untitled)" : title
      ..sinopsis = description == "" ? "(No sinopsis)" : description
      ..isCompleted = false;

    final box = Boxes.getTasks();
    box.add(task);
  }
}
class EditTaskModalWidget extends StatelessWidget {
  EditTaskModalWidget({Key key,  this.task}) : super(key: key);

  final Task task;

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Editar'),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children:  <Widget>[
                          TextFormField (
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskTitleController..text = task.titulo,
                          ),
                          const SizedBox(height: 10),
                          TextFormField (
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskDescriptionController..text = task.sinopsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Cerrar'),
                              onPressed: () => {
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Editar pelicula'),
                              onPressed: () => {
                                editTask(task),
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void editTask(Task task) {
    task.titulo = taskTitleController.text;
    task.sinopsis = taskDescriptionController.text;

    task.save();
  }
}


