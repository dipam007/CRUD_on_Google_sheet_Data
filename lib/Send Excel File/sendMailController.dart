import 'package:googlesheet_flutter_app/Send%20Excel%20File/sendMailClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SendMailController{
  final void Function(String) callback;

  static const String URL = "https://script.google.com/macros/s/AKfycbycgZDP82sIEoRYMWghxKEdL1T1IoHlQVy79tUs8swtpxEG8CzsnE0tpWb9iLzAaV09/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  SendMailController(this.callback);

  Future<void> sentMail(SendMailClass sendMailClass) async {
    try {

      await http.get(
          URL + sendMailClass.toParam()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });

    }catch(err){

    }
  }
}