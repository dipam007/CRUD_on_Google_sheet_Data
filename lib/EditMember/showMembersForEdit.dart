import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googlesheet_flutter_app/EditMember/editMember.dart';
import 'package:googlesheet_flutter_app/model/member.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ShowMembersForEdit extends StatefulWidget {
  @override
  _ShowMembersForEditState createState() => _ShowMembersForEditState();
}

class _ShowMembersForEditState extends State<ShowMembersForEdit> {

  List<Member> members = [];
  bool _isLoading=false;
  Timer timer;
  int noOfMembers=0;
  List<int> intList;

  @override
  void initState() {
    _getMembers();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getMembers());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _getMembers() async{
    var raw = await http.get("https://script.google.com/macros/s/AKfycbxWk8gFhlsd6G2k5JrltQrMWzuLFsuqxjVjUn4RK3w7yMZEyaxIEJhkkouVPNpvcRg4/exec");
    var memberData = convert.jsonDecode(raw.body);

    int count=0;
    memberData.forEach((element){
      if(element['id']!=null && element['name']!=null && element['mobile']!=null && element['email']!=null)
        count++;
    });

    if(count!=noOfMembers) {
      members = [];
      memberData.forEach((element){
        Member object = Member(id:"${element['id']}", name:element['name'], mobile:"${element['mobile']}", email:element['email']);
        members.add(object);
      });
      setState(() {
        noOfMembers = members.length;
      });
    }
  }

  Widget memberTileWidget(String id, String name, String mobile, String email){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: MaterialButton(
        color: Colors.white,
        elevation: 10.0,
        child: ListTile(
          leading: Icon(Icons.account_circle, size: 60,color: Colors.blueAccent,),
          title: Text(id+": "+name, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
          subtitle: Text(mobile),
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditMember(id: id, name: name, mobile: mobile, email: email,)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? Scaffold(
        backgroundColor: Colors.white70,
        body: Center(
          child: CircularProgressIndicator(backgroundColor: Colors.redAccent,strokeWidth: 5,),
        )
    ) : Scaffold(
      appBar: AppBar(
        title: Text("Members", style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold, fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index){

              members.sort((a, b){
                return (a.id).compareTo(b.id);
              });

              return memberTileWidget("${members[index].id}", members[index].name, "${members[index].mobile}", members[index].email);
                // MemberTile(id: "${members[index].id}", name: members[index].name, mobile: "${members[index].mobile}", email: members[index].email,)
            }
        ),
      ),
    );
  }
}
