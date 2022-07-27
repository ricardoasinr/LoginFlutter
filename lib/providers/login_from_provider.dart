import 'package:flutter/material.dart';
class LoginFormProvider extends ChangeNotifier{
  String email = ''; 
  String password = '';
 bool _isLoading = false;
 bool get isLoading => _isLoading;
 set isLoading(bool value){
  _isLoading = value;
  notifyListeners();
 }
 

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool isValidForm(){
    print(formKey.currentState?.validate() ?? false);
    print("$email - $password");
    
    return formKey.currentState?.validate() ?? false;
  }   
}