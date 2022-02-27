import 'package:flutter/material.dart';
import 'package:project/ui/home/homePage.dart';
import 'package:project/utils/colors.dart';

class DrawerView extends StatelessWidget {
    DrawerView({Key? key,required this.email}) : super(key: key);
String email;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return AppDrawer();
    });
  }
  Widget AppDrawer() {
    return Drawer(
      child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        _createDrawerHeader(),
        createDrawerItem(icon:const Icon(Icons.add,color: white,size: 20),text:"Add News"),
        createDrawerItem(icon:const Icon(Icons.newspaper,color: white,size: 20),text:"News"),
       ]),
    );
  }
  Widget _createDrawerHeader() {
    return DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset("assets/images/logo.png", width: 75,height:75),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:   [
                  Text(email),
                ],
              ),
            )
          ],
        )
    );
  }

  Widget createDrawerItem({required Icon icon, required String text}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            child:  ElevatedButton(
              onPressed: () {},
              child: icon,
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), primary: primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
            ),
          )
        ],
      ),
      onTap: () {

      },
    );
  }

 }



