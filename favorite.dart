import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:itqan/widgets/videos_player_page.dart';

import 'locales.dart';
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesManager().favoriteVideos;

    return Scaffold(
      appBar: AppBar(title: Text( LocaleData.body109.getString(context),
      )),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final video = favorites[index];
          return ListTile(
            leading: Image.asset(video['thumbnail']),
            title: Text(video['title']),
            subtitle: Text(video['Coursetype']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                FavoritesManager().removeFavorite(video);
                (context as Element).markNeedsBuild(); // Refresh the page
              },
            ),
            onTap: () {
              // Navigate to video player with this video
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideosPlayerPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
