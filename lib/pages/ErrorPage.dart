import 'package:flutter/material.dart';




class ErrorPage extends StatelessWidget {
  String error;
   ErrorPage({super.key,required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 160,),
          Text(error,style: const TextStyle(fontSize: 20),),
          IconButton(onPressed: () {Navigator.of(context).pop();},
           icon: const Icon(Icons.replay_outlined),iconSize: 70,)
        ]),
      ),
    );
  }
}