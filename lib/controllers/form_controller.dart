import 'dart:convert';
import 'package:demo_interview/models/survey.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  Survey survey = Survey(sections: []);
  Map<String, dynamic> response = {};
  Map<String, bool> visibleFields = {};

  @override
  void onInit() {
    super.onInit();
    loadJsonSurveyData();
  }

  Future<void> loadJsonSurveyData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data_form.json');
      survey = Survey.fromJson(jsonDecode(jsonString));
      updateFieldVisibility();
      update(); // Trigger initial update
    } catch (e) {
      Get.snackbar("Error", "Invalid JSON : $e");
    }
  }

  void updateResponse(String key, dynamic value) {
    response[key] = value;
    updateFieldVisibility();
    update(); // Ensure UI update
  }

  void updateCheckboxResponse(String key, String option, bool? checked) {
    if (checked == true) {
      response[key] = (response[key] ?? [])..add(option);
    } else {
      response[key]?.remove(option);
    }
    updateFieldVisibility();
    update(); // Ensure UI update
  }

  bool isFieldVisible(Field field) {
    if (field.conditional == null) return true;

    String dependsOn = field.conditional!.dependsOn!;
    dynamic valueData = response[dependsOn];

    return valueData == field.conditional!.value;
  }

  void updateFieldVisibility() {
    visibleFields.clear();
    for (var section in survey.sections) {
      for (var field in section.fields) {
        visibleFields[field.label!] = isFieldVisible(field);
      }
    }
    update(); // Ensure UI update
  }

  String? validateField(Field field, String? value) {
    final validation = field.validation;
    if (validation?.required == true && (value == null || value.isEmpty)) {
      return '${field.label} is required';
    }

    if (field.type == 'text' && validation?.minLength != null) {
      if (value!.length < validation!.minLength!) {
        return '${field.label} should be at least ${validation.minLength} characters long';
      }
    }

    if (field.type == 'number' && validation?.minValue != null) {
      int? numberValue = int.tryParse(value!);
      if (numberValue == null || numberValue < validation!.minValue!) {
        return '${field.label} should be at least ${validation?.minValue}';
      }
    }

    return null;
  }

  bool validationCheckField() {
    bool isValid = true;
    List<String> errorMessages = [];

    for (var section in survey.sections) {
      for (var field in section.fields) {
        var value = response[field.label] ?? '';

        if (visibleFields[field.label!] == true) {
          var errorMessage = validateField(field, value);
          if (errorMessage != null) {
            isValid = false;
            errorMessages.add(errorMessage);
          }
        }
      }
    }

    if (!isValid) {
      Get.snackbar("Validation Error", errorMessages.join("\n"));
    }
    return isValid;
  }

  void submitForm() {
    final submittedData = Map.fromEntries(
      response.entries.where((entry) => entry.value != null),
    );
    Get.snackbar("Form Submitted", "Response : ${jsonEncode(submittedData)}");
  }
}
