import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addClient.dart';

class ListClient extends StatefulWidget {
  const ListClient({Key? key}) : super(key: key);

  @override
  _ListClientState createState() => _ListClientState();
}

class _ListClientState extends State<ListClient> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Clients",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: firestore.collection("Client").get(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else if (snapshot.hasData) {
                print(snapshot.data);
                QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
                List<dynamic> list = querySnapshot.docs;
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  strokeWidth: 3,
                  onRefresh: () async {
                    setState(() {});
                  },
                  backgroundColor: Colors.purple,
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Add_client()),
                          );
                        },
                        child: Card(
                            child: ListTile(
                          title: Text(list[index].get("Nom") +
                              " " +
                              list[index].get("Prenom")),
                          leading: Image.asset("assets/images/imgclient.png"),
                          trailing: Icon(Icons.info),
                        )),
                      );
                    },
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Add_client()),
          );
          print("clicked");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
