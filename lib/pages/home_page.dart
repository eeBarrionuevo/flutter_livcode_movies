import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {

    getData();

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Movies",style: TextStyle(
            fontFamily: 'Montserrat'
        ),),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://papers.co/wallpaper/papers.co-vm29-poly-art-abstract-blue-green-pattern-25-wallpaper.jpg")
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"),
                    backgroundColor: Colors.white70,
                  ),
                  Text("Bienvenido Guillermo", style: TextStyle(
                    fontSize: 18
                  ),),
                  Text("Administrador", style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70
                  ))
                ],
              ),
            ),
            ListTile(
              title: Text("Películas"),
              trailing: Icon(Icons.local_movies),
              onTap: (){
                print("Hiciste tap en películas...");
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Televisión"),
              trailing: Icon(Icons.live_tv),
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Cerrar Sesión"),
              trailing: Icon(Icons.close),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        items:[
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favoritos")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text("Más Valoradas")
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        child: Icon(Icons.all_inclusive),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(
        child: Text("Home Page", style: TextStyle(
            fontFamily: 'Montserrat'
        ),),
      ),
    );
  }

  Future<Map> getJson() async {
    var apiKey = "077c6b8e215715b477754b84846c0f95";
    var url = 'http://api.themoviedb.org/3/discover/movie?api_key=$apiKey';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  void getData() async {
    var data = await getJson();
    print(data['results']);
  }


}
