import '../resources/repository.dart';
import '../models/login_model.dart';
import 'package:flutter/material.dart';
import '../common/functions/show_dialog_single_button.dart';

class LoginBloc {
  final _repository = Repository();

  login(BuildContext context, String username, String password) async {
    try{
      LoginModel result = await _repository.login(context, username, password);
      return result;
    } catch (err){
      showDialogSingleButton(context, "Unable to Login", "Wrong 'Username' / 'Password' combination.", "OK");
      return null;
    }
  }
}

final bloc = LoginBloc();
