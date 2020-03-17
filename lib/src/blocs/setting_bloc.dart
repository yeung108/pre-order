import '../resources/repository.dart';
import '../models/login_model.dart';
import 'package:flutter/material.dart';
import '../common/functions/show_dialog_single_button.dart';

class SettingBloc {
  final _repository = Repository();

  changePassword(BuildContext context, String oldPassword, String newPassword) async {
    try{
      LoginModel result = await _repository.changePassword(context, oldPassword, newPassword);
      return result;
    } catch (err){
      showDialogSingleButton(context, "Unable to Change Password", "Old Password is not correct", "OK");
      return null;
    }
  }
}

final bloc = SettingBloc();
