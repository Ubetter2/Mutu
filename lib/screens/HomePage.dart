import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mutu/Models/VideoTile.dart';
import 'package:mutu/globals.dart';
import 'package:mutu/smallWidgets/videoTile.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';

StreamController<int> streamController = StreamController<int>();

// ignore_for_file:lowercase_with_underscores

List<bool> sele = [true, false, false];
bool showFavs = false;
late Function listUpdate;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MyHomeScreen(streamController.stream),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  final Stream stream;

  const MyHomeScreen(this.stream);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      updateSt();
    });
  }

  void updateSt() {
    print("Called");
    setState(() {});
  }

  bool fav = false;
  int index = favs.length;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyProfileBar(),
        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width - 52,
                height: 490,
                decoration: BoxDecoration(
                    color: Color(0xffecdbbf),
                    borderRadius: BorderRadius.circular(40)),
                child: ListView.builder(
                    itemCount:
                        showFavs == false ? allVideoTiles.length : favs.length,
                    itemBuilder: (context, int index) {
                      return index != 0
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: showFavs == false
                                  ? allVideoTiles[index]
                                  : favs[index])
                          : allVideoTiles[index];
                    })),
            Column(
              children: [
                IconButton(
                  color: sele[0] == false ? Colors.black : Colors.red,
                  icon: Icon(Icons.video_collection_sharp),
                  iconSize: 30,
                  onPressed: () {
                    if (sele[0] != true) {
                      sele[0] = !sele[0];
                      showFavs = false;
                    }

                    sele[1] = false;
                    sele[2] = false;
                    setState(() {});
                  },
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                IconButton(
                  iconSize: 30,
                  color: sele[1] == false ? Colors.black : Colors.blue,
                  icon: Icon(Icons.history),
                  onPressed: () {
                    if (sele[1] != true) {
                      sele[1] = !sele[1];
                      showFavs = false;
                    }
                    sele[0] = false;
                    sele[2] = false;
                    setState(() {});
                  },
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                IconButton(
                  iconSize: 30,
                  color: sele[2] == false ? Colors.black : Colors.orange,
                  icon: Icon(Icons.star),
                  onPressed: () {
                    if (sele[2] != true) {
                      sele[2] = !sele[2];
                      showFavs = true;
                    }
                    sele[1] = false;
                    sele[0] = false;
                    setState(() {});
                  },
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class MyProfileBar extends StatefulWidget {
  const MyProfileBar({Key? key}) : super(key: key);

  @override
  _MyProfileBarState createState() => _MyProfileBarState();
}

class _MyProfileBarState extends State<MyProfileBar> {
  TextEditingController textEdi = TextEditingController();

  String getId(String url) {
    String? id = YoutubePlayer.convertUrlToId(url);
    if (id != null) {
      String vidId = id;
      return vidId;
    } else {
      throw Exception("URL Error");
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> getVideo(String url) async {
    var yt = YoutubeExplode();

    Video video = await yt.videos.get(url);

    Thumbnail myThumb = Thumbnail(Uri.parse(video.url), 60, 60);
    String title = video.title;

    print(video.title + video.author + video.duration.toString());

    allVideoTiles.add(MyVideoTile(
        allVideoTiles.length,
        VideoTile(
            video.title,
            video.author,
            video.duration.toString(),
            video.url.toString(),
            Image.network(
                "https://img.youtube.com/vi/" + getId(url) + "/0.jpg"))));

    showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Video"),
              content: SingleChildScrollView(
                  child: ListBody(children: [
                Text(title),
                Text(video.author),
                Text(video.duration.toString()),
                Image.network(
                    "https://img.youtube.com/vi/" + getId(url) + "/0.jpg")
              ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        key: _formKey,
        decoration: BoxDecoration(
            color: Color(0xfff4c67d),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black)),
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Column(children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
          Row(children: [
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
            IconButton(
              iconSize: 22,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
            Text(
              "Mutu",
              style: TextStyle(fontSize: 25),
            ),
            Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
            IconButton(
                iconSize: 22, icon: Icon(Icons.menu_rounded), onPressed: () {})
          ]),
          Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
          Container(
            width: 300,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black)),
            child: Container(
                width: 50,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: textEdi,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Text is empty";
                    }
                    return null;
                  },
                )),
          ),
          ElevatedButton(
              onPressed: () {
                if (textEdi.text.isNotEmpty) {
                  getVideo(textEdi.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please insert URL"),
                  ));
                }
              },
              child: Text("Done"))
        ]));
  }
}
