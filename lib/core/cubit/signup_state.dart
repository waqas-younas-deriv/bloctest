part of 'signup_cubit.dart';

enum FormzStatus { LOADING, FAILURE, SUCCESS,IDLE }

class SignupState {

  String email;
  String name;
  String password;
  FormzStatus formStatus;

  SignupState({this.email, this.name, this.password,
    this.formStatus,this.cup});

  String cup;



  SignupState copyWith({String email,
    String name,
    String password,
    FormzStatus formStatus,}) {
    return SignupState(email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      );
  }
}
