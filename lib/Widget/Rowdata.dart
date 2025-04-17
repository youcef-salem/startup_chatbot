import 'package:flutter/material.dart';

class Rowdata extends StatelessWidget {
  String rec;
  String data; 

  Rowdata({super.key
  
  , required this.rec, required this.data});

  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
          Container(
            width: 120,
            height: 85,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              
              color: Colors.transparent,
            ),
            child: Text(rec.toString(),style: TextStyle(color: Colors.white, fontSize: 20),),
      
          ), Container(
            width: 180,
            height: 85,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              
              color: Colors.transparent,
            ),
            child: Text(data.toString(),style: TextStyle(color: Colors.white,fontSize: 20)),
      
          )
      
        ],
     
    );
  }
}
