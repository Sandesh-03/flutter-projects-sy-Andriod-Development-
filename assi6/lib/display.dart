import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  String name;
  String number;
  String gender;
  String dob;
  String branch;

  Display(
      {Key? key,
      required this.number,
      required this.name,
      required this.branch,
      required this.dob,
      required this.gender})
      : super(key: key);

  TextStyle kStyle = const TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Display'),
        leading: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(33)),
              color: Colors.white),
          child: Image.asset(
            'assets/walchand_logo-removebg-preview.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 23, color: Colors.black45),
                  )),
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.orangeAccent,
                  ),
                  child: Card(
                    child: Center(
                        child: Text(
                          name,

                          style: kStyle,
                    )),
                  ),
                ),
              ),
              const FittedBox(
                  child: Text(
                    "Contact",
                    style: TextStyle(fontSize: 23, color: Colors.black45),
                  )),
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.orangeAccent,
                  ),
                  child: Card(
                    child: Center(
                        child: Text(
                          number,
                      style: kStyle,
                    )),
                  ),
                ),
              ),
              const FittedBox(
                  child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 23, color: Colors.black45),
                  )),
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.orangeAccent,
                  ),
                  child: Card(
                    child: Center(
                        child: Text(
                          gender,
                      style: kStyle,
                    )),
                  ),
                ),
              ),
              const FittedBox(
                  child: Text(
                    "Branch",
                    style: TextStyle(fontSize: 23, color: Colors.black45),
                  )),
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.orangeAccent,
                  ),
                  child: Card(
                    child: Center(
                        child: Text(branch
                      ,
                      style: kStyle,
                    )),
                  ),
                ),
              ),
              const FittedBox(
                  child: Text(
                    "Date Of Birth",
                    style: TextStyle(fontSize: 23, color: Colors.black45),
                  )),
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.orangeAccent,
                  ),
                  child: Card(
                    child: Center(
                        child: Text(dob,

                      style: kStyle,
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
