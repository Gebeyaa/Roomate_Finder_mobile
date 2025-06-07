import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ProfileSetupState {
  final int currentStep;
  final Map<String, dynamic> formData;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final bool isProfileComplete;

  ProfileSetupState({
    this.currentStep = 0,
    this.formData = const {},
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isProfileComplete = false,
  });

  ProfileSetupState copyWith({
    int? currentStep,
    Map<String, dynamic>? formData,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? isProfileComplete,
  }) {
    return ProfileSetupState(
      currentStep: currentStep ?? this.currentStep,
      formData: formData ?? this.formData,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }
}

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  static const String _apiUrl = 'https://arhibu-be.onrender.com/api/user/profile';
  final http.Client _httpClient;

  ProfileSetupCubit({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client(),
        super(ProfileSetupState());

  void nextStep() {
    emit(state.copyWith(currentStep: state.currentStep + 1));
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void updateFormData(Map<String, dynamic> newData) {
    final updatedData = Map<String, dynamic>.from(state.formData);
    updatedData.addAll(newData);
    emit(state.copyWith(formData: updatedData));
  }

  Future<void> submitProfile() async {
    if (!_isFormComplete()) {
      emit(state.copyWith(
        errorMessage: 'Please complete all steps before submitting',
        isSuccess: false,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    try {
      final apiData = _transformFormDataToApiFormat();

      final response = await _httpClient.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          // Add any required authentication headers here
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(apiData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(
          isSuccess: true,
          isLoading: false,
          isProfileComplete: true,
        ));
      } else {
        final errorData = jsonDecode(response.body);
        emit(state.copyWith(
          isLoading: false,
          errorMessage: errorData['message'] ?? 'Failed to update profile',
          isSuccess: false,
          isProfileComplete: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Error: ${e.toString()}',
        isSuccess: false,
        isProfileComplete: false,
      ));
    }
  }

  Map<String, dynamic> _transformFormDataToApiFormat() {
    // Extract data from the collected form data
    final personalInfo = state.formData['personal_info'] ?? {};
    final location = state.formData['location'] ?? {};
    final lifestyle = state.formData['lifestyle'] ?? {};
    final profile = state.formData['profile'] ?? {};
    final roomPreferences = state.formData['room_preferences'] ?? {};

    // Transform to API format, matching backend field names exactly
    return {
      // Exact matches with backend
      "fullname": personalInfo['full_name'] ?? '',
      "userPicture": profile['profile_image'] ?? '',
      "verificationDocs": [], // Empty for now
      "age": int.tryParse(personalInfo['age']?.toString() ?? '') ?? 0,
      "sex": personalInfo['gender'] ?? '', // Changed from gender to sex to match backend
      "nationality": personalInfo['home_town'] ?? '', // Changed from home_town to nationality to match backend
      "education": personalInfo['occupation'] ?? '', // Changed from occupation to education to match backend
      "bio": roomPreferences['description'] ?? '',
      "website": "", // Empty for now
      "location": "${location['city'] ?? ''}, ${(location['neighborhoods'] as List?)?.join(', ') ?? ''}",

      // Additional fields that backend will handle (keeping as is)
      "state": personalInfo['state'] ?? '',
      "relationship_status": personalInfo['relationship_status'] ?? '',
      "cleanliness": state.formData['lifestyle']?['cleanliness'] ?? '',
      "work_hours": state.formData['lifestyle']?['work_hours'] ?? '',
      "sleep_hours": state.formData['lifestyle']?['sleep_hours'] ?? '',
      "tobacco_relationship": state.formData['lifestyle']?['tobacco_relationship'] ?? '',
      "alcohol_relationship": state.formData['lifestyle']?['alcohol_relationship'] ?? '',
      "room_city": roomPreferences['room_city'] ?? '',
      "room_subcity": roomPreferences['room_subcity'] ?? '',
      "bedrooms": int.tryParse(roomPreferences['bedrooms']?.toString() ?? '') ?? 0,
      "bathrooms": int.tryParse(roomPreferences['bathrooms']?.toString() ?? '') ?? 0,
      "furniture": roomPreferences['furniture'] ?? '',
      "apartment_type": roomPreferences['apartment_type'] ?? '',
      "amenities": roomPreferences['amenities'] ?? [],
    };
  }

  bool _isFormComplete() {
    // Check if all required steps are completed
    final personalInfo = state.formData['personal_info'] ?? {};
    final location = state.formData['location'] ?? {};
    final lifestyle = state.formData['lifestyle'] ?? {};
    final profile = state.formData['profile'] ?? {};
    final roomPreferences = state.formData['room_preferences'] ?? {};

    // Check required fields
    if (personalInfo['full_name']?.toString().isEmpty ?? true) return false;
    if (personalInfo['age']?.toString().isEmpty ?? true) return false;
    if (personalInfo['gender']?.toString().isEmpty ?? true) return false;
    if (personalInfo['occupation']?.toString().isEmpty ?? true) return false;
    if (personalInfo['relationship_status']?.toString().isEmpty ?? true) return false;
    if (personalInfo['home_town']?.toString().isEmpty ?? true) return false;

    // Check location
    if ((location['neighborhoods'] as List?)?.isEmpty ?? true) return false;

    // Check lifestyle
    if (lifestyle['cleanliness']?.toString().isEmpty ?? true) return false;
    if (lifestyle['work_hours']?.toString().isEmpty ?? true) return false;
    if (lifestyle['sleep_hours']?.toString().isEmpty ?? true) return false;
    if (lifestyle['tobacco_relationship']?.toString().isEmpty ?? true) return false;
    if (lifestyle['alcohol_relationship']?.toString().isEmpty ?? true) return false;

    // Check profile
    if (profile['profile_image']?.toString().isEmpty ?? true) return false;

    // Check room preferences
    if (roomPreferences['bedrooms']?.toString().isEmpty ?? true) return false;
    if (roomPreferences['bathrooms']?.toString().isEmpty ?? true) return false;
    if (roomPreferences['description']?.toString().isEmpty ?? true) return false;

    return true;
  }

  void reset() {
    emit(ProfileSetupState());
  }

  @override
  Future<void> close() {
    _httpClient.close();
    return super.close();
  }
}
