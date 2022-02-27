import 'package:flutter/material.dart';
import 'package:project/ui/drawer/drawer_view.dart';
class HomePage extends StatefulWidget {
    HomePage({Key? key,required this.email}) : super(key: key);
String email;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerView(email:widget.email),
    );
  }
}
