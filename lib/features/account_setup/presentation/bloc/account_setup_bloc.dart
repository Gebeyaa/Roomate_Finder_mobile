import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'account_setup_event.dart';
part 'account_setup_state.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  AccountSetupBloc() : super(const AccountSetupState()) {
    on<UpdatePersonalInfo>(_onUpdatePersonalInfo);
    on<UpdateStep>(_onUpdateStep);
    on<SubmitForm>(_onSubmitForm);
  }

  void _onUpdatePersonalInfo(
    UpdatePersonalInfo event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(state.copyWith(
      state: event.state,
      age: event.age,
      gender: event.gender,
      offeringRoom: event.offeringRoom,
      budget: event.budget,
      moveInDate: event.moveInDate,
      leaseDuration: event.leaseDuration,
    ));
  }

  void _onUpdateStep(
    UpdateStep event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(state.copyWith(currentStep: event.step));
  }

  Future<void> _onSubmitForm(
    SubmitForm event,
    Emitter<AccountSetupState> emit,
  ) async {
    emit(state.copyWith(formStatus: SubmissionInProgress()));
    
    try {
      // Here you would call your API/service to submit the form
      // await accountService.submitAccountSetup(state);
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
    }
  }
}