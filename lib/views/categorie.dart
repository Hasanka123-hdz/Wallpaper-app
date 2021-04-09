import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/modal/wallpaper_model.dart';
import 'package:wallpaper_app/widget/widget.dart';

class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({this.categorieName});


  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query ) async{
    var response = await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=30&page=1'),
        headers: {
          "Authorization" : apiKey
        });
    //print(response.body.toString());
    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //  print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {

    });
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("ICONIC"),
      ),
      body: SingleChildScrollView(
        child: Container(child: Column(
          children: [
            SizedBox(height: 12,),
            wallpapersList(wallpapers:wallpapers, context: context),
          ],
        ),),
      ) ,
    );
  }
}
