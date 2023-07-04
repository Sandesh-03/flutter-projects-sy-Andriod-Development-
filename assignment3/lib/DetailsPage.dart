import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  String name;
  String email;
  String prn;
  String branch;
   Details({Key? key, required this.email,required this.branch,required this.name,required this.prn}) : super(key: key);
 static const kTextStyle=TextStyle(
   fontSize: 30,
   fontWeight: FontWeight.bold,
   color: Colors.white
 );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(),
          FittedBox(child: Text('Name: $name',style: kTextStyle,)),
          const SizedBox(height: 20,),
          FittedBox(child: Text('Email: $email',style: kTextStyle,)),
          const SizedBox(height: 20,),
          FittedBox(child: Text('PRN: $prn',style: kTextStyle,)),
          const SizedBox(height: 20,),
          FittedBox(child: Text('Branch: $branch',style: kTextStyle,)),
        ],
      ),
    );
  }
}
