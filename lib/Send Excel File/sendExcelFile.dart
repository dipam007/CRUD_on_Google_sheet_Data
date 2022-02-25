import 'package:flutter/material.dart';
import 'package:googlesheet_flutter_app/Send%20Excel%20File/sendMailClass.dart';
import 'package:googlesheet_flutter_app/Send%20Excel%20File/sendMailController.dart';

class SendExcelFile extends StatefulWidget {
  @override
  _SendExcelFileState createState() => _SendExcelFileState();
}

class _SendExcelFileState extends State<SendExcelFile> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController?.dispose();
    _bodyController?.dispose();
    _emailController?.dispose();
  }

  void _sent(){
    if(_formKey.currentState.validate()){
      SendMailClass sendMailClass = SendMailClass(_titleController.text, _bodyController.text, _emailController.text);

      SendMailController sendMailController = SendMailController((String response){
        print("Response: "+ response);
        if(response == SendMailController.STATUS_SUCCESS){
          _showSnakBar("Mail Sent Perfectly");
        }
        else{
          _showSnakBar("Error occurred!!!");
        }
      }
      );
      _showSnakBar("Mail Sending...");
      sendMailController.sentMail(sendMailClass);
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
        title: Text("Mail Sending Page", style: TextStyle(letterSpacing: 2.0),),
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
                    controller: _titleController,
                    validator: (val){
                      return val.isEmpty ? "Enter valid Title" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the Title"
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextFormField(
                    controller: _bodyController,
                    validator: (val){
                      return val.isEmpty ? "Enter valid Body" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter the Body"
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
                      child: Text("Sent Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2.0),),
                      onPressed: _sent
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
