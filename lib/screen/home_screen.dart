import 'package:demo_interview/controllers/form_controller.dart';
import 'package:demo_interview/models/survey.dart';
import 'package:demo_interview/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FormController controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: controller.loadJsonSurveyData(),
        builder: (context, snapshot) {
          // Show loader while data is loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If there is an error, show an error message
          if (snapshot.hasError) {
            return Center(
              child: Text("Error Loading Survey: ${snapshot.error}"),
            );
          }

          // Show form only when the data is successfully loaded
          if (snapshot.connectionState == ConnectionState.done) {
            return GetBuilder<FormController>(
              init: controller,
              builder: (_) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.survey.sections.length,
                  itemBuilder: (context, index) {
                    final section = controller.survey.sections[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            section.title!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...section.fields.map((field) {
                          return _buildField(field);
                        }).toList(),
                        const Divider(),
                      ],
                    );
                  },
                );
              },
            );
          }

          // Fallback - show loader if future state is not determined
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.validationCheckField()) {
            controller.submitForm();
            Get.snackbar("Success", "Form submitted successfully");
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildField(Field field) {
    if (!controller.isFieldVisible(field)) return const SizedBox.shrink();

    switch (field.type) {
      case 'text':
        return _buildTextField(field);
      case 'number':
        return _buildNumberField(field);
      case 'radio':
        return _buildRadioField(field);
      case 'checkbox':
        return _buildCheckboxField(field);
      case 'dropdown':
        return _buildDropdownField(field);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTextField(Field field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: CommonTextField(
        hintText: field.placeholder ?? "",
        labelText: field.label,
        onChanged: (value) {
          controller.updateResponse(field.label!, value);
          controller.update(); // Ensure UI update
        },
        validator: (value) {
          return controller.validateField(field, value);
        },
      ),
    );
  }

  Widget _buildNumberField(Field field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: CommonTextField(
        keyboardType: TextInputType.number,
        hintText: field.placeholder ?? "",
        labelText: field.label,
        onChanged: (value) {
          controller.updateResponse(field.label!, value);
          controller.update(); // Ensure UI update
        },
        validator: (value) {
          return controller.validateField(field, value);
        },
      ),
    );
  }

  Widget _buildRadioField(Field field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: field.options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: controller.response[field.label],
            onChanged: (value) {
              controller.updateResponse(field.label!, value);
              controller.update(); // Ensure UI update
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCheckboxField(Field field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: field.options.map((option) {
          return CheckboxListTile(
            title: Text(option),
            value: controller.response[field.label]?.contains(option) ?? false,
            onChanged: (checked) {
              controller.updateCheckboxResponse(field.label!, option, checked);
              controller.update(); // Ensure UI update
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDropdownField(Field field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: field.label),
        items: field.options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          controller.updateResponse(field.label!, value);
          controller.update(); // Ensure UI update
        },
        validator: (value) => controller.validateField(field, value!),
      ),
    );
  }
}
