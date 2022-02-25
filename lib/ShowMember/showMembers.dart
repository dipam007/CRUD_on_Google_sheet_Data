import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googlesheet_flutter_app/DeleteMember/deleteSheetController.dart';
import 'package:googlesheet_flutter_app/ShowMember/memberDetails.dart';
import 'package:googlesheet_flutter_app/model/deleteMemberClass.dart';
import 'package:googlesheet_flutter_app/model/member.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ShowMembers extends StatefulWidget {
  @override
  _ShowMembersState createState() => _ShowMembersState();
}

class _ShowMembersState extends State<ShowMembers> {

  List<Member> members = [];
  Timer timer;
  int noOfMembers=0;

  final _searchController = TextEditingController();
  List<Member> searchMemberList = [];

  @override
  void initState() {
   _getMembers();
   timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getMembers());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _searchController?.dispose();
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

  void _deleteMember(String id){
    DeleteMemberClass deleteMemberClass = DeleteMemberClass(id);

    DeleteSheetController deleteSheetController = DeleteSheetController(
            (String response){
          print("Response: "+ response);
          if(response == DeleteSheetController.STATUS_SUCCESS){}
          else{}
        }
    );
    deleteSheetController.deleteForm(deleteMemberClass);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => MemberDetails(id: id, name: name, mobile: mobile, email: email,)));
        },
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchMemberList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    members.forEach((userDetail) {
      if (userDetail.id.contains(text) || userDetail.name.toLowerCase().contains(text.toLowerCase()))
        searchMemberList.add(userDetail);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members", style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold, fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: _searchController,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        _searchController.clear();
                        onSearchTextChanged('');
                      },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: searchMemberList.length != 0 || _searchController.text.isNotEmpty
                  ? new ListView.builder(
                      itemCount: searchMemberList.length,
                      itemBuilder: (context, index) {
                        return memberTileWidget("${searchMemberList[index].id}", searchMemberList[index].name, "${searchMemberList[index].mobile}", searchMemberList[index].email);
                      },
                  )
                  : new ListView.builder(
                      itemCount: members.length,
                      itemBuilder: (context, index){

                      members.sort((a, b){
                        return (a.id).compareTo(b.id);
                      });

                      return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            padding: EdgeInsets.only(right: 20),
                            alignment: Alignment.centerRight,
                            color: Colors.redAccent,
                            child: Text("DELETE", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,letterSpacing: 1.0),),
                          ),
                          child: memberTileWidget("${members[index].id}", members[index].name, "${members[index].mobile}", members[index].email),
                          onDismissed: (DismissDirection direction){
                            if(direction.toString() == "DismissDirection.endToStart"){
                              _deleteMember(members[index].id);
                            }
                        },
                      );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
