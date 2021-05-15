import 'package:flutter/material.dart';
import 'package:wallpaper_app/utils/db_provider.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  dynamic _fetchedFavorites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          elevation: 0.0,
        ),
        body: _fetchedFavorites.isEmpty
        ? FutureBuilder(
          future: DatabaseHelper.instance.queryAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        size: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('No Favorites'),
                    ],
                  ),
                );
              }
              _fetchedFavorites = snapshot.data.map(
                (favoriteWallpaper) => GestureDetector(
                  child: Card(
                    margin: EdgeInsets.all(16),
                    elevation: 1,
                      child: Column(
                      children: <Widget>[
                        Hero(
                            tag: favoriteWallpaper['_id'],
                            child: Image.network(favoriteWallpaper['name'])),
                      ],
                    ),
                  ),
                ),
              );
              return _renderFavorites(forceRefresh: false);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
            : _renderFavorites(forceRefresh: true),
    );
  }

  Widget _renderFavorites({bool forceRefresh}) {
    if (forceRefresh) {
      DatabaseHelper.instance.queryAll().then((favorites) {
        if (favorites.length != _fetchedFavorites.length) {
          setState(() {
            _fetchedFavorites = [];
          });
        }
      });
    }
    return ListView(
      children: <Widget>[
        ..._fetchedFavorites,
      ],
    );
  }
}
