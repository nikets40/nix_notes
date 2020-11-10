import 'package:fluttertoast/fluttertoast.dart';

class Toast{
  showShortToast(String message){
    Fluttertoast.showToast(msg: message);
  }
}