import 'package:flutter/material.dart';

class MemberDetails extends StatefulWidget {

  final id, name, mobile, email;
  MemberDetails({this.id, this.name, this.mobile, this.email});
  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id + ": "+widget.name),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: " + widget.id, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,letterSpacing: 2.0)),
            SizedBox(height: 15,),
            Text("Name: " + widget.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,letterSpacing: 2.0)),
            SizedBox(height: 15,),
            Text("Mobile: " + widget.mobile, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,letterSpacing: 2.0)),
            SizedBox(height: 15,),
            Text("Email: " + widget.email, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 2.0),),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
