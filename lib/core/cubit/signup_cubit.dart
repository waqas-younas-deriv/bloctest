import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';

import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState());

  void email(String value) {
    emit(state.copyWith(email: value));
  }

  void password(String value) {
    emit(state.copyWith(password: value));
  }

  void name(String value) {
    emit(state.copyWith(name: value));
  }

  bool _validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String validatePassword(String val, String cPass) {
    if (val.isEmpty || val == null) {
      return 'Please enter your password';
    } else if (val != cPass) {
      return 'Password does not match confirm password';
    } else if (!_validateStructure(val)) {
      return 'Please enter a strong password';
    } else {
      password(val);
      return null;
    }
  }

  String validateName(String val) {
    if (val.isEmpty || val == null) {
      return 'Please enter your name';
    } else if (val.contains(" ")) {
      return 'Name should not contain any space';
    }
    return null;
  }

  String validateEmail(String val) {
    if (val.isEmpty || val == null) {
      return 'Please enter your Email';
    } else if (!EmailValidator.validate(val)) {
      return 'Please enter correct Email';
    }
    return null;
  }

  Future<void> signUpFormSubmitted() async {
    emit(state.copyWith(formStatus: FormzStatus.LOADING));

    try {
      emit(state.copyWith(formStatus: FormzStatus.SUCCESS));
      emit(state.copyWith(formStatus: FormzStatus.IDLE));
    } on Exception {
      emit(state.copyWith(formStatus: FormzStatus.FAILURE));
    }
  }
}
