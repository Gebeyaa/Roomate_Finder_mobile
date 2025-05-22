part of 'account_setup_bloc.dart';

abstract class AccountSetupEvent extends Equatable {
  const AccountSetupEvent();

  @override
  List<Object> get props => [];
}

class UpdatePersonalInfo extends AccountSetupEvent {
  final String? state;
  final String? age;
  final String? gender;
  final String? offeringRoom;
  final String? budget;
  final String? moveInDate;
  final String? leaseDuration;

  const UpdatePersonalInfo({
    this.state,
    this.age,
    this.gender,
    this.offeringRoom,
    this.budget,
    this.moveInDate,
    this.leaseDuration,
  });
}

class UpdateStep extends AccountSetupEvent {
  final int step;

  const UpdateStep(this.step);
}

class SubmitForm extends AccountSetupEvent {}