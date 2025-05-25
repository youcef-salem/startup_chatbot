import 'package:flutter/material.dart';

class CustumSnackbare extends StatelessWidget {
  final BuildContext context;

  const CustumSnackbare({super.key, required this.context});

  SnackBar show() {
    return SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      backgroundColor: Colors.black.withOpacity(0.7),
      duration: const Duration(
       minutes: 3,
      ), // Long duration since we'll manually dismiss it
      content: Container(
     
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
         
         
          children: [
            Container(
             
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF00FF9B).withOpacity(0.3)),
              ),
              child: Icon(Icons.mic, color: Color(0xFF00FF9B), size: 24),
            ),
            SizedBox(width: 16),
           
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
        side: BorderSide(color: Color(0xFF00FF9B).withOpacity(0.3), width: 1),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
