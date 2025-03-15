import 'package:flutter/material.dart';
class cuDrawer extends StatelessWidget {
  const cuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
    backgroundColor: Color.fromARGB(255, 12, 51, 59),
     
         
           child: Column(
           children: [
            Padding(
           padding: const EdgeInsets.only(top: 50,left: 15),
           child: 
             Row( children: [Text(
                'Startup ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
           
              Image.asset('assets/startup.png', height: 40, width: 40),
              Text(
                ' Chatbot',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )],),
            
           
            ),
             Padding(
               padding: const EdgeInsets.only(top: 50,left: 10),
               
               child: Row(
                
                 children: [
                  Text("My acount",style: TextStyle(fontSize: 40,color: Colors.white),),
                   IconButton(
                    icon: Icon(Icons.account_circle,size: 80,color:  Colors.white,),
                    onPressed: () {
                     
                    }, 
                     ),
                 ],
               ),
                           
             ),
              Padding(
               padding: const EdgeInsets.only(top: 50,left: 10),
               
               child: Row(
                
                 children: [
                  Text("Last Chat ",style: TextStyle(fontSize: 40 ,color: Colors.white),),
                   IconButton(
                    icon: Icon(Icons.list,size: 80,color:  Colors.white),
                    onPressed: () {
                     
                    }, 
                     ),
                 ],
               ),
                           
             ),
            Padding(
               padding: const EdgeInsets.only(top: 50,left:  10),
               
               child: Row(
                
                 children: [
                  Text("Support",style: TextStyle(fontSize: 40,color: Colors.white),),
                   IconButton(
                    icon: Icon(Icons.help,size: 80,color:  Colors.white,),
                    onPressed: () {
                     
                    }, 
                     ),
                 ],
               ),
                           
             ),
           
          
          ],
           
           
           ),
            
         
    );
  }
}