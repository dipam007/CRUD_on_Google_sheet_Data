import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlesheet_flutter_app/EditMember/showMembersForEdit.dart';
import 'file:///C:/Users/aa/AndroidStudioProjects/googlesheet_flutter_app/lib/AddMember/addMember.dart';
import 'file:///C:/Users/aa/AndroidStudioProjects/googlesheet_flutter_app/lib/ShowMember/showMembers.dart';
import 'package:googlesheet_flutter_app/Send%20Excel%20File/sendExcelFile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home Page", style: TextStyle(letterSpacing: 3.0, fontWeight: FontWeight.w600, fontSize: 25),),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 2,child: SizedBox(),),
          Expanded(
            flex: 2,
            child: MaterialButton(
                splashColor: Colors.green,
                elevation: 30.0,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width*0.8,
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, right: MediaQuery.of(context).size.width*0.1),
                    height: 80,
                    color: Colors.grey,
                    child: Text("SEND EXCEL FILE", style: TextStyle(letterSpacing: 2.0, color: Colors.white, fontSize: 22),)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SendExcelFile()));
                }
            ),
          ),
          Expanded(flex: 1,child: SizedBox(),),
          Expanded(
            flex: 2,
            child: MaterialButton(
                splashColor: Colors.green,
                elevation: 30.0,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width*0.8,
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, right: MediaQuery.of(context).size.width*0.1),
                    height: 80,
                    color: Colors.grey,
                    child: Text("ADD MEMBERS", style: TextStyle(letterSpacing: 2.0, color: Colors.white, fontSize: 22),)
                ),
                onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddMember()));
                }
            ),
          ),
          Expanded(flex: 1,child: SizedBox(),),
          Expanded(
            flex: 2,
            child: MaterialButton(
                splashColor: Colors.redAccent,
                elevation: 10.0,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, right: MediaQuery.of(context).size.width*0.1),
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 80,
                    color: Colors.teal,
                    child: Text("SHOW MEMBERS", style: TextStyle(letterSpacing: 2.0, color: Colors.white, fontSize: 22),)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowMembers()));
                }
            ),
          ),
          Expanded(flex: 1,child: SizedBox(),),
          Expanded(
            flex: 2,
            child: MaterialButton(
              splashColor: Colors.blue,
                elevation: 10.0,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, right: MediaQuery.of(context).size.width*0.1),
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 80,
                    color: Colors.blueGrey,
                    child: Text("EDIT MEMBERS", style: TextStyle(letterSpacing: 2.0, color: Colors.white, fontSize: 22),)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowMembersForEdit()));
                }
            ),
          ),
          Expanded(flex: 2,child: SizedBox(),),
        ],
      ),
    );
  }
}
