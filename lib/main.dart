import 'dart:io';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Image Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Image currentImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: () async {
              try {
                FilePickerCross myFile =
                    await FilePickerCross.importFromStorage(
                  type: FileTypeCross.image,
                );

                if (myFile != null) {
                  setState(() {
                    currentImage = Image.file(File(myFile.path));
                  });
                }
              } on FileSelectionCanceledError {} on Exception {}
            },
          )
        ],
      ),
      body: Center(
        child: currentImage == null ? Text("choose an image") : currentImage,
      ),
    );
  }
}
