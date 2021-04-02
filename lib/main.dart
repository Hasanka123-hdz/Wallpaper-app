import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red[50],
        accentColor: Color(0xFFFEF9EB),
      ),
      home: Search(),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ICONIC"),
        actions: [
          IconButton(icon: Icon(Icons.search), splashRadius: 22, onPressed: () {
            showSearch(
                context: context, delegate: DataSearch()
            );
          },)
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String>{

  final cities = [
    "Anuradhapura",
    "Colombo",
    "Pilimathalawa",
    "Matale"
  ];

  final recentCities = [
    "Anuradhapura",
    "Matale"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(icon: Icon(Icons.clear), splashRadius: 22, onPressed: () {
        query = "";
      })
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return
      IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,), onPressed: (){
        close(context, null);
      });
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty?recentCities:cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context,index)=> ListTile(
      onTap: (){
        showResults(context);
      },
      leading: Icon(Icons.category),
      title: RichText(text: TextSpan(
        text: suggestionList[index].substring(0, query.length),
        style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold
        ),
        children: [
          TextSpan(
            text: suggestionList[index].substring(query.length),
            style: TextStyle(color: Colors.grey)
          )
        ]
      )),
    ),
      itemCount: suggestionList.length,
    );
    throw UnimplementedError();
  }
  
}





 