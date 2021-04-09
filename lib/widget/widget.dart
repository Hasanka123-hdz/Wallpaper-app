import 'package:flutter/material.dart';
import 'package:wallpaper_app/modal/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget wallpapersList({List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ImageView(
                    imgUrl: wallpaper.src.portrait,
                  )
              ));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: Image.network(wallpaper.src.portrait, fit: BoxFit.cover,),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}