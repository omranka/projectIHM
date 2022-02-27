import 'package:flutter/material.dart';

import 'camera_widget.dart';

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  @override
  Widget build(BuildContext context) {
    return CameraWidget();
  }
}
