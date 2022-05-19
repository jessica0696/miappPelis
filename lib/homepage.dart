import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app_flutter/taskpage.dart';

import 'main.dart';
import 'model/task.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String dropDownValue;

  var languages = ["English", "espanol", "Pусский"];

  final usernameController = TextEditingController();

  bool isUsernameEmpty() {
    if(usernameController.text.trim() != "" && dropDownValue != null) {
      return false;
    }else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 150),
            Container(
              width: double.infinity,
              height: 70,
              color: Colors.blue,
              child: const Text(
                'Hola Bienvenido!',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              alignment: Alignment.center,
            ),

            DropdownButtonHideUnderline(
              child: DropdownButton<String>(

                value: dropDownValue,
                style: const TextStyle(color: Colors.black, fontSize: 30),
                onChanged: (String newValue){
                  setState(() {
                    dropDownValue = newValue;
                  });
                },

                alignment: Alignment.center,
                hint: const Text(
                  "Elige un lenguaje",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 20,
                  ),
                ),
                items: languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(child: Text(value)),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskPage()),
                );
              },
              child: const Text(
                  "Next"
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 40),
                primary: isUsernameEmpty() ? Colors.green[300] : Colors.blue,
              ),
            ),

          ],

        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
