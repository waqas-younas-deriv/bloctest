import 'package:bloc/bloc.dart';


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
