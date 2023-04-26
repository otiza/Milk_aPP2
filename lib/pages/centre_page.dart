import "package:flutter/material.dart";
import "package:milk_collection/api/Post.dart";
import "package:milk_collection/models/data_models.dart";
import "package:milk_collection/pages/collection_input.dart";
import "package:url_launcher/url_launcher.dart";
import 'package:maps_launcher/maps_launcher.dart';

Future<void> call(String number) async{
  if(await canLaunchUrl(Uri.parse("tel:$number"))) {
     await launchUrl(Uri.parse("tel:$number"));
  }
  else {
    throw("can't call");
  }

}
class CentreCollection extends StatefulWidget {
  final Tournee tournee;
  final int index;
  const CentreCollection({super.key, required this.tournee, required this.index});

  @override
  State<CentreCollection> createState() => _CentreCollectionState();
}

class _CentreCollectionState extends State<CentreCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("${widget.tournee.trajetIds![widget.index].name}"),
          backgroundColor: Colors.blueGrey,
        ),
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(108, 96, 125, 139),
                  ),
                  width: 100,
                  height: 100,
                  child: IconButton(
                    onPressed: () {  
                      call("${widget.tournee.trajetIds![widget.index].producerId?.phone}").catchError((error) {
                        print(error);
                      });                  
                    },
                    icon: const Icon(Icons.call),
                    iconSize: 80,
                    tooltip: "call",                
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(108, 96, 125, 139),
                  ),
                  width: 100,
                  height: 100,
                  child: IconButton(
                    onPressed: () {                    
                      MapsLauncher.launchCoordinates(widget.tournee.trajetIds![widget.index].latitude ?? 0, widget.tournee.trajetIds![widget.index].longitude ?? 0);
                    },
                    icon: const Icon(Icons.navigation),
                    iconSize: 80,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(108, 96, 125, 139),
                ),
                width: 100,
                height: 100,
                child: IconButton(
                  onPressed: () async {  
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>
                     collecInput(tournee: widget.tournee, index: widget.index)));
                  },
                  icon: const Icon(Icons.edit_document),
                  iconSize: 80,
                ),
              ),
            )
          ],
        )));
  }
}
