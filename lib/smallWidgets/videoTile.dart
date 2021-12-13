import 'package:flutter/material.dart';
import 'package:mutu/globals.dart';
import 'package:mutu/screens/HomePage.dart';
import 'package:mutu/Models/VideoTile.dart';

class MyVideoTile extends StatefulWidget {
  int index;
  VideoTile vidTile;

  MyVideoTile(this.index, this.vidTile);

  @override
  _MyVideoTileState createState() => _MyVideoTileState();
}

class _MyVideoTileState extends State<MyVideoTile> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(color: Colors.redAccent),
        key: ValueKey("Hello"),
        onDismissed: (direction) {
          print(allVideoTiles.length.toString());
          allVideoTiles.removeAt(widget.index);
          streamController.add(widget.index);
          print("th ind" + widget.index.toString());

          print(allVideoTiles.length.toString());
          if (fav == true) {
            favs.removeAt(widget.index);
            streamController.add(widget.index);
          }
        },
        child: Container(
          width: 340,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    width: 60,
                    height: 60,
                    child: widget.vidTile.thumbnail),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          widget.vidTile.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(widget.vidTile.author,
                          style: TextStyle(color: Colors.grey)),
                      Text(widget.vidTile.time.toString(),
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: IconButton(
                    icon: Icon(!widget.vidTile.fav
                        ? Icons.star_border_outlined
                        : Icons.star),
                    onPressed: () {
                      setState(() {
                        widget.vidTile.fav = !widget.vidTile.fav;
                        if (widget.vidTile.fav == true) {
                          favs.add(allVideoTiles[widget.index]);
                        } else {
                          favs.removeAt(widget.index);
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
