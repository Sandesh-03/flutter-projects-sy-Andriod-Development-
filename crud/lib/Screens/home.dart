import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/Screens/add.dart';
import 'package:crud/reusables.dart';
import 'package:crud/Screens/userDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DocumentReference flutterdocId;

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');
  late Stream<QuerySnapshot> studentStream;
  TextEditingController kNameUpdated = TextEditingController();
  TextEditingController kAgeUpdated = TextEditingController();

  @override
  void initState() {
    super.initState();
    studentStream = _reference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Add()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: studentStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //Check error
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }

            //Check if data arrived
            if (snapshot.connectionState == ConnectionState.active) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //Convert the documents to Maps
              List<Map> student = documents
                  .map((sta1) =>
                      {'id': sta1.id, 'name': sta1['name'], 'age': sta1['age']})
                  .toList();
              if (kDebugMode) {
                print(student.length);
              }
              //Display the list
              return ListView.builder(
                  itemCount: student.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Get the item at this index
                    Map thisItem = student[index];
                    //REturn the widget for the list items
                    return SizedBox(
                      height: 70,
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: Colors.deepPurple.shade100,
                              onPressed: ((context) {
                                updateUser(snapshot.data.docs[index].id);
                              }),
                              icon: Icons.edit,
                            ),
                            SlidableAction(
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: Colors.deepPurple.shade100,
                              onPressed: ((context) async {
                                // deleteUser();
                                deleteUser(snapshot.data.docs[index].id);
                              }),
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => UserDetails(
                                          id: snapshot.data.docs[index].id,
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.deepPurple[100]),
                            child: ListTile(
                                title: Text('${thisItem['name']}'),
                                subtitle: Text('${thisItem['age']}')),
                          ),
                        ),
                      ),
                    );
                  });
            }

            //Show loader
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void deleteUser(id) {
    FirebaseFirestore.instance.collection('students').doc(id).delete();
  }

  Future updateUser(id) {
    CollectionReference _ref =
        FirebaseFirestore.instance.collection('students');

    return showDialog(
        context: (context),
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Update detais"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kTextFormField(
                      lable: 'name',
                      kController: kNameUpdated,
                      obscure: false,
                      icon: const Icon(Icons.person),
                      validator: (val) {
                        if (val == null) {
                          print('This field can not be empty ');
                        }
                      }),
                  const SizedBox(height: 30),
                  kTextFormField(
                    lable: "age",
                    kController: kAgeUpdated,
                    obscure: false,
                    icon: const Icon(Icons.escalator_warning_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' age Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          _ref.doc(id).update({
                            'name': kNameUpdated.text,
                            'age': kAgeUpdated.text
                          });

                          kAgeUpdated.clear();
                          kNameUpdated.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: kButtontext,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
