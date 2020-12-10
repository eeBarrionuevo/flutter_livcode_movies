import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var movies;
  var image_url = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Movies",
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
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
                      image: NetworkImage(
                          "https://papers.co/wallpaper/papers.co-vm29-poly-art-abstract-blue-green-pattern-25-wallpaper.jpg"))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://schooloflanguages.sa.edu.au/wp-content/uploads/2017/11/placeholder-profile-sq.jpg"),
                    backgroundColor: Colors.white70,
                  ),
                  Text(
                    "Bienvenido Guillermo",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text("Administrador",
                      style: TextStyle(fontSize: 14, color: Colors.white70))
                ],
              ),
            ),
            ListTile(
              title: Text("Películas"),
              trailing: Icon(Icons.local_movies),
              onTap: () {
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
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Favoritos")),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), title: Text("Más Valoradas")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.all_inclusive),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Text(
              "Top Populares",
              style: TextStyle(
                  fontSize: 35,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movies == null ? 0 : movies.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      child: Container(
                        width: 90,
                        height: 90,
                      ),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(
                                  image_url + movies[index]['poster_path']),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 7,
                                offset: Offset(2, 5))
                          ]),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movies[index]['title'],
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5,),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.star, size: 16,),
                                  Text(movies[index]['popularity'].toString(), style: TextStyle(
                                    fontSize: 12
                                  ),)
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              movies[index]['overview'],
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],

                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
    movies = data['results'];
    setState(() {});
  }
}
