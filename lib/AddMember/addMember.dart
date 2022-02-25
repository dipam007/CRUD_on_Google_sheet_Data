import 'package:flutter/material.dart';
import 'package:googlesheet_flutter_app/model/sheetForm.dart';
import 'file:///C:/Users/aa/AndroidStudioProjects/googlesheet_flutter_app/lib/AddMember/sheetController.dart';

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  void _submit(){
    if(_formKey.currentState.validate()){
      SheetForm sheetForm = SheetForm(_idController.text, _nameController.text, _mobileController.text, _emailController.text);

      SheetController sheetController = SheetController(
              (String response){
            print("Response: "+ response);
            if(response == SheetController.STATUS_SUCCESS){
              _showSnakBar("New Member Added in Sheet");
              _idController.text = '';
              _nameController.text = '';
              _mobileController.text = '';
              _emailController.text = '';
            }
            else{
              _showSnakBar("Error occurred!!!");
            }
          }
      );
      _showSnakBar("Submitting Sheet...");
      sheetController.submitForm(sheetForm);
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
        title: Text("Add Member", style: TextStyle(letterSpacing: 2.0),),
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
                    controller: _idController,
                    validator: (val){
                      return val.isEmpty ? "Enter valid ID" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the ID"
                    ),
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
                      child: Text("Add Member", style: TextStyle(color: Colors.white, letterSpacing: 2.0),),
                      onPressed: _submit
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
