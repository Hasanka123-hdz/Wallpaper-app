import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/modal/categories_modal.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/modal/wallpaper_model.dart';
import 'package:wallpaper_app/views/categorie.dart';
import 'package:wallpaper_app/views/image_view.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/widget/widget.dart';


//////////////////////////////////

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

//////////////////////////////// get wallpapers
  getTrendingWallpapers() async{
    var response = await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=15&page=1'),
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
    getTrendingWallpapers();
    categories = getCategories();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("ICONIC"),
          // actions: [
          //   IconButto n(
          //     icon: Icon(Icons.search),
          //     splashRadius: 22,
          //     onPressed: () {
          //     // showSearch(
          //     //     context: context, delegate: DataSearch()
          //     // );
          //   },)
          // ],
        ),//
        drawer: Sidenav(),

        body: SingleChildScrollView(

          child: Container(
            child: Column(children: [
              SizedBox(height: 7,),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "Search wallpapers",
                              border: InputBorder.none),
                        ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            )
                        ));
                      },
                      child: Container(
                        child: Icon(Icons.search)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Container(
                height: 60,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){

                  return CategoriesTile(
                    title: categories[index].categorieName,
                    imgUrl: categories[index].imgUrl,
                  );
                }),
              ),
              SizedBox(height: 12,),
              wallpapersList(wallpapers:wallpapers, context: context),
            ],),
          ),
        ),
    );
  }
}

///////////////////////// Sidenav
class Sidenav extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('ICONIC', style: TextStyle(fontSize: 21, color: Colors.red),),
          ),
          Divider(color: Colors.grey.shade400, ),

          ListTile(
            title: Text('All Inbox'),
            leading: Icon(Icons.move_to_inbox,  color: Colors.black,),
            onTap: (){

            },
          ),

          Divider(color: Colors.grey.shade400),

          ListTile(
            title: Text('Primary'),
            leading: Icon(Icons.inbox,  color: Colors.black,),
            trailing: Text('44', style: TextStyle(fontWeight: FontWeight.w500),),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('Social'),
            leading: Icon(Icons.group,  color: Colors.black,),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('Promotions'),
            leading: Icon(Icons.local_offer,  color: Colors.black,),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('Favorites'),
            leading: Icon(Icons.star, color: Colors.black,),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('Snoozed'),
            leading: Icon(Icons.schedule, color: Colors.black, ),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('Important'),
            leading: Icon(Icons.local_offer,  color: Colors.black,),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('Sent'),
            leading: Icon(Icons.local_offer,  color: Colors.black,),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('Scheduled'),
            leading: Icon(Icons.local_offer,  color: Colors.black,),
            onTap: (){

            },
          ),
        ],
      ),
    );
  }
}
////////////////////////


class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.title,@required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Categorie(
           categorieName: title.toLowerCase(),
          )
        ));
      },
      child: Container(
      margin: EdgeInsets.only(right: 4),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.cover, color: Color.fromRGBO(200, 200, 0, 0.85), colorBlendMode: BlendMode.modulate ),
        ),
        Container(
          height: 50, width: 100,
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15,),),),
      ],),
      ),
    );
  }
}
