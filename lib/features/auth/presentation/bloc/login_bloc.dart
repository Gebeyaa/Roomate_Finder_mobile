import 'package:arhibu/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      final result = await RemoteDatasource().login(
        event.email,
        event.password,
      );
      if (result.success) {
        emit(LoginSuccess("Login successful!"));
      } else {
        print('Login error: \\${result.errorMessage}');
        emit(LoginFailure(result.errorMessage ?? "Invalid email or password."));
      }
    });
  }
}
