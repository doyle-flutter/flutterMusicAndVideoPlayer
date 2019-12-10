//audioplayers: ^0.13.5
//video_player: ^0.10.4+1

// pubspec.yaml
// flutter:
//  assets:
//   - assets/

// [AppName]/assets/ncs.mp3

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(
  MaterialApp(
    home:MyApp()
  )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int keepValue;
  PageController pc;
  var res;

  @override
  void initState() {
    keepValue = 1;
    pc = new PageController(
      initialPage: 0
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 500,
              height: 500,
              child: PageView(
                controller: pc,
                children: <Widget>[
                  Container(
                    width:200,
                    height: 200,
                    color: Colors.red,
                    child: Center(child: Text(keepValue.toString())),
                  ),
                  Container(
                    width:200,
                    height: 200,
                    color: Colors.red,
                    child: Center(child: Text("2")),
                  ),
                  Container(
                    width:200,
                    height: 200,
                    color: Colors.red,
                    child: Center(child: Text("3")),
                  ),
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () async{
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageTwo()
                      )
                  );
                  if(result != null){
                    setState(() {
                      res = result;
                    });
                    print(result);
                  }
                },
                child: Text("Page Move"),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: (){
                  setState(() {
                    this.keepValue++;
                  });
                },
                child: Text("Value ++"),
              ),
            )


          ],
        ),
      ),
    );
  }
}



class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {

  AudioPlayer audioPlayer;
  AudioCache audioCache;

  VideoPlayerController _controller;

  @override
  void initState() {

    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
    _controller = VideoPlayerController.network(
      'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4'
    )..initialize();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, 'Yep!');
                },
                child: Text('Yep!'),
              ),
              FlatButton(
                onPressed: (){
                  audioCache.play('ncs.mp3');
                },
                child: Text("PLAY"),
              ),
              FlatButton(
                onPressed: () async{
                  audioPlayer.pause();
                },
                child: Text("PAUSE"),
              ),
              FlatButton(
                onPressed: () async{
                  audioPlayer.stop();
                },
                child: Text("STOP"),
              ),
              Container(
                width: 200,
                height: 200,
                child: VideoPlayer(_controller)
              ),
              Container(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        this._controller.play();
                      },
                      child: Icon(Icons.play_arrow),
                    ),
                    FlatButton(
                      onPressed: (){
                        this._controller.pause();
                      },
                      child: Icon(Icons.pause),
                    ),
                    FlatButton(
                      onPressed: () async{
                        this._controller.seekTo(
                          Duration(seconds: 0)
                        ).then((_){
                          this._controller.pause();
                        });
                      },
                      child: Icon(Icons.stop),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    audioPlayer.dispose();
    audioPlayer.dispose();
  }

}
