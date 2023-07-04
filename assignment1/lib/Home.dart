import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String kName= "Flutter";
  TextEditingController kNameController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text(
          'Assignment 1',style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Text("Hello $kName !!",style: const TextStyle(
                fontSize: 30,fontWeight: FontWeight.bold,
              ),),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              style: const TextStyle(
                fontSize: 20,
                color: Colors.yellow
              ),
              controller: kNameController,
              decoration: InputDecoration(
                labelText: 'Enter your Name',
                labelStyle:const TextStyle(
                  fontSize: 20
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),


            ),

            ElevatedButton(onPressed: (){
              setState(() {
             if (kNameController.text == null || kNameController.text  ==""){
               kName ='Flutter';
             }else{
               kName=kNameController.text.trim();
             }

              });
              kNameController.clear();

            }, child: const Text(
              'submit'
            ))
          ],
        ),
      ),
    );
  }
}
