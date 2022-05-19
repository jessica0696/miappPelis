
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app_flutter/taskpage.dart';
import 'package:movie_app_flutter/homepage.dart';
import 'package:movie_app_flutter/peliculas.dart';
import 'package:url_strategy/url_strategy.dart';

import 'model/task.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

 await Hive.openBox<Task>('task');

  setPathUrlStrategy();
  runApp(new MyApp());


}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
    '/':(context)=>FirstPagina(),
    '/peliculas':(context)=>Home(),
    '/administrador':(context)=>TaskPage()
    },
    theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),

    );
  }
}
class FirstPagina extends StatelessWidget {
  @override

  Widget build(BuildContext context) {return Scaffold(
      appBar: AppBar(title: Text('Hola Usuario'),),
      body: Stack(children: [

        Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/allmovies1.png") ) ),
        ),
        Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Text("Hola", style: TextStyle(color: Colors.white, fontSize:28.0,fontWeight: FontWeight.bold,
            ),
            ),
            const Text("INGRESA TU USUARIO", style: TextStyle(color: Colors.white, fontSize:28.0,fontWeight: FontWeight.bold
            ),
            ),
            const SizedBox(height: 44.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.mail, color: Colors.white),
              ),
            ),
            const SizedBox(height: 26.0,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.password, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12.0,),
            const Text("no recuerdas tu usuario o contrasena",
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 18.0,
            ),
            Container(
              width: 80.0,
              child: RaisedButton(child: Text('ingresar'),
                onPressed: ()
                {
                  Navigator.pushNamed(context, '/peliculas');
                },),

            )
          ],
        ),
      ])

  );
  }
}



