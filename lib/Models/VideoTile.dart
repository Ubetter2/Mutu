

import 'package:flutter/cupertino.dart';

class VideoTile{
  String name;
  String author;
  String time;
  Image thumbnail;
  String url;
  bool fav = false;

  VideoTile(this.name,this.author,this.time,this.url, this.thumbnail);
}