import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/cubit/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BlocProvider<SignupCubit>(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.formStatus == FormzStatus.FAILURE) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Sign Up Failure'),
              duration: Duration(seconds: 2),
            ));
          } else if (state.formStatus == FormzStatus.SUCCESS) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('SignUp successfull welcome ${state.name}'),
              duration: Duration(seconds: 2),
            ));
          } else if (state.formStatus == FormzStatus.LOADING) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Loading ..........'),
              duration: Duration(seconds: 3),
            ));
          } else {
            print('nothing');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Demo Signup Bloc',
                      style: TextStyle(color: Colors.blue, fontSize: 30),
                    ),
                    formField(
                        context: context,
                        field: 'Name',
                        hint: 'Please enter your Name',
                        validator: (val) {
                          return  context.read<SignupCubit>().validateName(val);
                        },
                        onSaved: (val) {
                          context.read<SignupCubit>().name(val);
                        },
                        obscure: false),
                    formField(
                        context: context,
                        field: 'Email',
                        hint: 'Please enter your Email',
                        validator: (val) {
                        return  context.read<SignupCubit>().validateEmail(val);
                        },
                        onSaved: (val) {
                          context.read<SignupCubit>().email(val);
                        },
                        obscure: false),
                    formField(
                        context: context,
                        field: 'Password',
                        hint: 'Please enter your Password',
                        validator: (val) {
                          return context
                              .read<SignupCubit>()
                              .validatePassword(val,confirmPassword);
                        },
                        onSaved: (val) {
                          password = val;
                        },
                        obscure: true),
                    formField(
                        context: context,
                        field: 'Confirm Password',
                        hint: 'Please re-enter your password',
                        validator: (val) {
                        return context
                              .read<SignupCubit>()
                              .validatePassword(val,password);
                        },
                        onSaved: (val) {
                          confirmPassword = val;
                        },
                        obscure: true),
                    InkWell(
                      onTap: () async {
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          await context
                              .read<SignupCubit>()
                              .signUpFormSubmitted();
                        }
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.only(top: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: Text(
                          'SignUp',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    )));
  }

  Widget formField(
      {BuildContext context,
      String field,
      String hint,
      FormFieldValidator validator,
      FormFieldSetter onSaved,
      bool obscure}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field,
                style: TextStyle(color: Colors.blue),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  decoration: InputDecoration.collapsed(hintText: hint),
                  validator: validator,
                  obscureText: obscure,
                  onSaved: onSaved,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
