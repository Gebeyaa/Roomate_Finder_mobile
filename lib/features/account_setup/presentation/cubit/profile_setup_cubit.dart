import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_setup_state.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  ProfileSetupCubit() : super(ProfileSetupState.initial());

  static const int totalSteps = 5; // Adjust based on your actual step count

  // Moves to the next step if current step is valid
  void nextStep() {
    if (state.currentStep < totalSteps - 1) {
      emit(
        state.copyWith(currentStep: state.currentStep + 1, errorMessage: ''),
      );
    }
  }

  // Goes back to previous step
  void previousStep() {
    if (state.currentStep > 0) {
      emit(
        state.copyWith(currentStep: state.currentStep - 1, errorMessage: ''),
      );
    }
  }

  void updateFormData(Map<String, dynamic> data) {
    final newFormData = Map<String, dynamic>.from(state.formData);
    newFormData.addAll(data);

    emit(
      state.copyWith(
        formData: newFormData,
        completedSteps: {...state.completedSteps, state.currentStep},
        errorMessage: '',
      ),
    );
  }

  bool isCurrentStepComplete() {
    switch (state.currentStep) {
      case 0: // Personal Info
        return state.formData.containsKey('name') &&
            state.formData.containsKey('email');
      case 1: // Location
        return state.formData.containsKey('city') &&
            (state.formData['neighborhoods'] as List?)?.isNotEmpty == true;
      default:
        return true;
    }
  }

  Future<void> submit() async {
    if (!_isFormComplete()) {
      emit(
        state.copyWith(
          errorMessage: 'Please complete all steps before submitting',
        ),
      );
      return;
    }
    emit(state.copyWith(isSubmitting: true, errorMessage: ''));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Submission failed: ${e.toString()}',
        ),
      );
    }
  }

  bool _isFormComplete() {
    return state.completedSteps.length == totalSteps;
  }

  void reset() {
    emit(ProfileSetupState.initial());
  }
}
