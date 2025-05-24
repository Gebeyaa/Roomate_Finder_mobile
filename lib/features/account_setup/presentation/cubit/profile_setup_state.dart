part of 'profile_setup_cubit.dart';

class ProfileSetupState {
  final int currentStep;
  final Map<String, dynamic> formData;
  final Set<int> completedSteps;
  final bool isSubmitting;
  final bool isSuccess;
  final String errorMessage;

  const ProfileSetupState({
    required this.currentStep,
    required this.formData,
    required this.completedSteps,
    required this.isSubmitting,
    required this.isSuccess,
    required this.errorMessage,
  });

  // Initial state
  factory ProfileSetupState.initial() => const ProfileSetupState(
    currentStep: 0,
    formData: {},
    completedSteps: {},
    isSubmitting: false,
    isSuccess: false,
    errorMessage: '',
  );

  // Copy with method for immutability
  ProfileSetupState copyWith({
    int? currentStep,
    Map<String, dynamic>? formData,
    Set<int>? completedSteps,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ProfileSetupState(
      currentStep: currentStep ?? this.currentStep,
      formData: formData ?? this.formData,
      completedSteps: completedSteps ?? this.completedSteps,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileSetupState &&
        other.currentStep == currentStep &&
        other.formData == formData &&
        other.completedSteps == completedSteps &&
        other.isSubmitting == isSubmitting &&
        other.isSuccess == isSuccess &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return currentStep.hashCode ^
        formData.hashCode ^
        completedSteps.hashCode ^
        isSubmitting.hashCode ^
        isSuccess.hashCode ^
        errorMessage.hashCode;
  }
}
