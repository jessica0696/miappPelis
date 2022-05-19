import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/widgets.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/trending.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'homepage.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  }
}

class Home extends StatefulWidget { @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('segunda pagina'),),
    body: Center(
      child: RaisedButton(child: Text('pagina principal'),
        onPressed: ()
        {

        },),
    ),
  );
}
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '67af5e631dcbb4d0981b06996fcd47bc';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2FmNWU2MzFkY2JiNGQwOTgxYjA2OTk2ZmNkNDdiYyIsInN1YiI6IjYwNzQ1OTA0ZjkyNTMyMDAyOTFmZDczYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C_Bkz_T8OybTGo3HfYsESNjN46LBYdw3LHdF-1TzYYs';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.blue,
          child: Column(
            children: [
              UserAccountsDrawerHeader(accountName: Text('Jessica'), accountEmail: Text('Jessica@gmail.com'),
                currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('images/user.png')
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Início'),
                subtitle: Text('Pagina Peliculas'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/peliculas');
                },
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('tv Shows'),
                subtitle: Text('Popular TV shows'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/peliculas');
                },
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Trending'),
                subtitle: Text('Trending Movies'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/peliculas');
                },
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Top Rated'),
                subtitle: Text('Top Rated Movies'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/peliculas');
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Logout'),
                subtitle: Text('Cerrar Sesion'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text(
                    "Mis peliculas"
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  // primary: isUsernameEmpty() ? Colors.blueGrey[200] : Colors.blue,
                ),
              ),
            ],

          ),

        ),
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: modified_text(text: 'ALL MOVIES :)️'),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            TV(tv: tv),
            TrendingMovies(
              trending: trendingmovies,
            ),
            TopRatedMovies(
              toprated: topratedmovies,
            ),

          ],

        ),
        floatingActionButton: NewTaskModalWidget()
    );
  }
}