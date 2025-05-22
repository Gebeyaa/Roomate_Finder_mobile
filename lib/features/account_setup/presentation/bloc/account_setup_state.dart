part of 'account_setup_bloc.dart';

class AccountSetupState extends Equatable {
  final int currentStep;
  final String? state;
  final String? age;
  final String? gender;
  final String? offeringRoom;
  final String? budget;
  final String? moveInDate;
  final String? leaseDuration;
  final FormSubmissionStatus formStatus;

  const AccountSetupState({
    this.currentStep = 0,
    this.state,
    this.age,
    this.gender,
    this.offeringRoom,
    this.budget,
    this.moveInDate,
    this.leaseDuration,
    this.formStatus = const InitialFormStatus(),
  });

  AccountSetupState copyWith({
    int? currentStep,
    String? state,
    String? age,
    String? gender,
    String? offeringRoom,
    String? budget,
    String? moveInDate,
    String? leaseDuration,
    FormSubmissionStatus? formStatus,
  }) {
    return AccountSetupState(
      currentStep: currentStep ?? this.currentStep,
      state: state ?? this.state,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      offeringRoom: offeringRoom ?? this.offeringRoom,
      budget: budget ?? this.budget,
      moveInDate: moveInDate ?? this.moveInDate,
      leaseDuration: leaseDuration ?? this.leaseDuration,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        state,
        age,
        gender,
        offeringRoom,
        budget,
        moveInDate,
        leaseDuration,
        formStatus,
      ];
}

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class SubmissionInProgress extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final Exception exception;

  const SubmissionFailed(this.exception);
}