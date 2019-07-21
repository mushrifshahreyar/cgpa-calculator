import 'package:cgpa_calculator/screen/cgpaShower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CGPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.red
        ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}
class HomePageState extends State<HomePage> {
  
  // TextEditingController controller_cgpa;
  // TextEditingController controller_credit;
  final List<String> semester = ['1st Sem','2nd Sem','3rd Sem','4th Sem','5th Sem','6th Sem','7th Sem','8th Sem'];
  String input_sem = '1st Sem';
  List<double> input_cpga = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
  List<int> input_credit = [0,0,0,0,0,0,0,0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar : AppBar(
       title: Text('CGPA Calculator'),
       centerTitle: true, 
      ),
      body: Column(
        children: <Widget>[
          dropdownSemSelector(),
          inputWidget(),
          calculateButton(),
        ],
      )
    );
  }
  
  Widget calculateButton() {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      height: MediaQuery.of(context).size.height * 0.075,
      width: MediaQuery.of(context).size.width * 0.4,
      child : RaisedButton(
      color: Colors.redAccent,
      child: Text('Calculate',style: TextStyle(fontSize: 19, color: Colors.white),),

      onPressed: () {
        double cgpa=0;
        cgpa = calculateCgpa();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CgpaShower(cgpa: cgpa),
        ),);
      }
    ),
    );
  }
  
  double calculateCgpa() {
    double cgpa = 0;
    double numerator = 0;
    double denominator = 0;
    for(int i=0;i<=semester.indexOf(input_sem);++i) {
      numerator+=(input_cpga[i] * input_credit[i]);
      denominator += input_credit[i];
    }
    if(denominator != 0) {
      cgpa = numerator/denominator;
    }
    else {
      cgpa = 0;
    }
    return cgpa;
  }

  Widget inputWidget() {
    bool _validate = false;
    bool _validateCredit = false;
    bool _v = false;
    bool _c = false;
    String errorCredit = "";
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height * 0.60,
      maxWidth: MediaQuery.of(context).size.width * 0.5,
      child : Container(
        // padding: EdgeInsets.only(top: 10.0),
        child : ListView.builder(
          itemCount: (semester.indexOf(input_sem)+1),
          itemBuilder: (context,int i) {
            
          return Card(
            elevation: 1,
            child: Row(
            children: <Widget>[
              Flexible(
                flex : 4,
                child: Container(
                padding: EdgeInsets.all(10.0),
                child : TextField(
                    decoration: InputDecoration(
                    labelText : 'CGPA Semester ${i+1}',
                    border: OutlineInputBorder(),
                    hintText: '0.00',
                    errorText: _validate? 'Value should be less than 10' : '',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    double v = double.parse(val);
                    input_cpga[i] = v;
                    if(v > 10.0 || v == 0) {
                      input_cpga[i] = 0.0;
                      _v = true;
                    }
                    else {
                      _v = false;
                    }
                    setState(() {
                      _validate = _v;
                    });                    
                  },
                  onSubmitted: (val) {
                    double value = double.parse(val);
                    if(value > 10.0 || value == 0) {
                      input_cpga[i] = 0.0;
                      _v = true;
                    }
                    else {
                      input_cpga[i] = value;
                      _v = false;
                    }

                    setState(() {
                      _validate = _v;
                    });
                  },
                ),
              ),
              ),
              Flexible(
                flex : 2,
                child: Container(
                padding: EdgeInsets.all(10.0),
                child : TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText : 'Credits',
                    hintText: '22',
                    errorText: errorCredit,
                  ),
                  keyboardType: TextInputType.number,
                  
                  onChanged: (val) {
                    int v = int.parse(val);
                    input_credit[i] = v;
                    if(v > 30 || v < 0) {
                      input_credit[i] = 0;
                      setState(() {
                        errorCredit = 'invalid';  
                        print(errorCredit);
                      });
                      

                    }
                    // checkCredit(val);
                  },
                  onSubmitted: (val) {
                    int value = int.parse(val);
                    if(value > 30 || value == 0) {
                      input_credit[i] = 0;
                    }
                    else {
                      input_credit[i] = value;
                    }
                  },
                ),
              ),
              ),
            ],
          ),
          );
          
        },
        
      ),
    ),
    );
  }
  void checkCredit(String val) {
    if(int.parse(val) > 40 && int.parse(val) < 0) {
      
    }
  }
  Widget dropdownSemSelector() {
    return Flexible(
      child : Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.008),
      height: MediaQuery.of(context).size.height * 0.11,
      child: DropdownButton(
        hint: Text('Total semesters Completed'),
        items: semester.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child:Text(value,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              )
            );
          }).toList(),
          value: input_sem,
          onChanged: (value) {
            input_sem = value;
            setState(() {});
          },
          isExpanded: true,
        ),
      ),
    );
  }
}