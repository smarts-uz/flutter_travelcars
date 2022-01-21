
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponent {
  static showDialog(String msg, ) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
    );
  }
}