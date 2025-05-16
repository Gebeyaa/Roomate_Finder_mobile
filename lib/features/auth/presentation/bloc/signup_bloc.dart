import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupSubmitted) {
      // Simulate a signup process
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay

      if (event.email.isNotEmpty && event.password.length >= 6) {
        yield SignupSuccess("Signup successful!");
      } else {
        yield SignupFailure("Invalid email or password.");
      }
    }
  }
}