import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'list.dart';
import 'list_client.dart';

class Add_client extends StatefulWidget {
  const Add_client({Key? key}) : super(key: key);
  @override
  _Add_clientState createState() => _Add_clientState();
}

class _Add_clientState extends State<Add_client> {
  final TextEditingController controllerNom = TextEditingController();
  final TextEditingController controllerPrenom = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final elements1 = [
    "Homme",
    "Femme",
  ];

  int selectedIndex1 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout Client",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Nom"),
                    controller: controllerNom,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Prenom"),
                    controller: controllerPrenom,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Sexe",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                DirectSelect(
                    itemExtent: 50.0,
                    selectedIndex: selectedIndex1,
                    backgroundColor: Colors.white,
                    child: MySelectionItem(
                      isForList: false,
                      title: elements1[selectedIndex1],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex1 = index!;
                      });
                    },
                    items: _buildItems1()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await firestore.collection("Client").add({
                        "Nom": controllerNom.text,
                        "Prenom": controllerPrenom.text,
                        "Sexe": elements1[selectedIndex1]
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListClient()),
                      );
                      setState(() {});
                    },
                    child: Text("ADD"),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
