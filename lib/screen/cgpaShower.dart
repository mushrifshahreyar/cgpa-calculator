import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class CgpaShower extends StatelessWidget {
  double cgpa = 0;
  CgpaShower({@required this.cgpa});
  
  @override
  Widget build(BuildContext context) {
    String cgpa_val = "";
    print(cgpa);
    if(cgpa == 0) {
      cgpa_val = 'Invalid';
    }
    else {
      cgpa_val = cgpa.toStringAsFixed(2);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('CGPA is :'),
      ),
      body: Center(
        child: Text(
          cgpa_val,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent
          ),
        ),
      ), 
    );
  }
}