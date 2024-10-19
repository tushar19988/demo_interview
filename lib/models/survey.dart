class Survey {
  Survey({
    required this.sections,
  });

  final List<Section> sections;

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      sections: json["sections"] == null
          ? []
          : List<Section>.from(
              json["sections"]!.map((x) => Section.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "sections": sections.map((x) => x.toJson()).toList(),
      };
}

class Section {
  Section({
    required this.title,
    required this.fields,
  });

  final String? title;
  final List<Field> fields;

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json["title"],
      fields: json["fields"] == null
          ? []
          : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "fields": fields.map((x) => x.toJson()).toList(),
      };
}

class Field {
  Field({
    required this.type,
    required this.label,
    required this.placeholder,
    required this.validation,
    required this.options,
    required this.conditional,
  });

  final String? type;
  final String? label;
  final String? placeholder;
  final Validation? validation;
  final List<String> options;
  final Conditional? conditional;

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      type: json["type"],
      label: json["label"],
      placeholder: json["placeholder"],
      validation: json["validation"] == null
          ? null
          : Validation.fromJson(json["validation"]),
      options: json["options"] == null
          ? []
          : List<String>.from(json["options"]!.map((x) => x)),
      conditional: json["conditional"] == null
          ? null
          : Conditional.fromJson(json["conditional"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "label": label,
        "placeholder": placeholder,
        "validation": validation?.toJson(),
        "options": options.map((x) => x).toList(),
        "conditional": conditional?.toJson(),
      };
}

class Conditional {
  Conditional({
    required this.dependsOn,
    required this.value,
  });

  final String? dependsOn;
  final String? value;

  factory Conditional.fromJson(Map<String, dynamic> json) {
    return Conditional(
      dependsOn: json["dependsOn"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "dependsOn": dependsOn,
        "value": value,
      };
}

class Validation {
  Validation({
    required this.required,
    this.minLength,
    this.minValue,
    this.maxValue,
    this.pattern,
  });

  final bool? required; // Nullable
  final int? minLength; // Nullable
  final int? minValue; // Nullable
  final int? maxValue; // Nullable
  final String? pattern; // Nullable

  factory Validation.fromJson(Map<String, dynamic> json) {
    return Validation(
      required: json["required"],
      minLength: json["minLength"],
      minValue: json["minValue"],
      maxValue: json["maxValue"],
      pattern: json["pattern"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "minLength": minLength,
      "minValue": minValue,
      "maxValue": maxValue,
      "pattern": pattern,
    };
    if (required != null) {
      data["required"] = required;
    }
    return data;
  }
}
