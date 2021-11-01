
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponent {
  static showDialog(String msg, ) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
    );
  }
}