import 'package:flutter/material.dart';
import 'package:googlesheet_flutter_app/EditMember/editSheetController.dart';
import 'package:googlesheet_flutter_app/model/editMemberClass.dart';

class EditMember extends StatefulWidget {
  final id, name, mobile, email;
  EditMember({this.id, this.name, this.mobile, this.email});
  @override
  _EditMemberState createState() => _EditMemberState();
}

class _EditMemberState extends State<EditMember> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _nameController.text = widget.name;
    _mobileController.text = widget.mobile;
    _emailController.text = widget.email;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController?.dispose();
    _mobileController?.dispose();
    _emailController?.dispose();
  }

  void _save(){
    if(_formKey.currentState.validate()){
      EditMemberClass editMemberClass = EditMemberClass(widget.id, _nameController.text, _mobileController.text, _emailController.text);

      EditSheetController editSheetController = EditSheetController((String response){
            print("Response: "+ response);
            if(response == EditSheetController.STATUS_SUCCESS){
              _showSnakBar("Member Perfectly Edited");
            }
            else{
              _showSnakBar("Error occurred!!!");
            }
          }
      );
      _showSnakBar("Editing Member...");
      editSheetController.editForm(editMemberClass);
    }
  }

  _showSnakBar(String message){
    final snakBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snakBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Member", style: TextStyle(letterSpacing: 2.0),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 25),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.id,
                    readOnly: true,
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    controller: _nameController,
                    validator: (val){
                      return val.isEmpty ? "Enter valid Name" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the name"
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    controller: _mobileController,
                    validator: (val){
                      return val.isEmpty || val.length!=10 ? "Enter valid mobile" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the mobile number"
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    controller: _emailController,
                    validator: (val){
                      return val.isEmpty ? "Enter valid Email" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the email"
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    color: Colors.blueGrey,
                      padding: EdgeInsets.all(10),
                      elevation: 10.0,
                      splashColor: Colors.redAccent,
                      child: Text("SAVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2.0),),
                      onPressed: _save
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
