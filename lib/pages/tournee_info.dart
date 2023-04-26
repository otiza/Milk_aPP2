import 'package:flutter/material.dart';
import 'package:milk_collection/api/Get.dart';
import 'package:milk_collection/models/data_models.dart';
import 'package:milk_collection/pages/ErrorPage.dart';
import 'centre_page.dart';

class TourneeInfo extends StatefulWidget {
  dynamic id;
  dynamic number;

  TourneeInfo({
    Key? key,
    @required this.id,
    @required this.number,
  }) : super(key: key);

  @override
  State<TourneeInfo> createState() => _TourneeInfoState();
}

class _TourneeInfoState extends State<TourneeInfo> {
  late Tournee tournee = Tournee();
  bool built = false;
  @override
  Widget build(BuildContext context) {
    if (built == false) {
      getTourneeId(widget.id).then((Tournee result) {
        setState(() {
          tournee = result;
          built = true;
        });
      }).catchError((error) {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ErrorPage(error: error.message))
          );
      });
    }
    
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("tournee  number ${widget.number}"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
          itemCount: tournee.trajetIds?.length ?? 0,
          itemBuilder: ((context, index) {
            return ListTile(
                title: Text("${tournee.trajetIds![index].name}"),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CentreCollection(
                              tournee: tournee, index: index)));
                });
          })),
    );
  }
}
