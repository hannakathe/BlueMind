// models/educational_resource_model.dart

class EducationalResource {
  final String id;
  final String title;
  final String summary;
  final Content content; // Cambiado de String a objeto Content
  final String imageUrl;
  final List<String> galleryImages;
  final String author;
  final DateTime publishDate;
  final DateTime lastUpdate;
  final List<String> tags;
  final int estimatedTime; // in minutes
  final bool isFeatured;
  final String subject;
  final String educationalLevel;
  final int views;
  final List<ResourceReference> relatedResources;

  EducationalResource({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.imageUrl,
    this.galleryImages = const [],
    required this.author,
    required this.publishDate,
    required this.lastUpdate,
    this.tags = const [],
    required this.estimatedTime,
    this.isFeatured = false,
    required this.subject,
    required this.educationalLevel,
    this.views = 0,
    this.relatedResources = const [],
  });

  factory EducationalResource.fromJson(Map<String, dynamic> json) {
    // Función para parsear listas de strings de forma segura
    List<String> _parseStringList(dynamic data) {
      if (data is! List) return [];
      return data.whereType<String>().toList();
    }

    // Función para parsear fechas
    DateTime _parseDateTime(dynamic date) {
      if (date is DateTime) return date;
      if (date is String) return DateTime.tryParse(date) ?? DateTime.now();
      return DateTime.now();
    }

    // Función para parsear enteros
    int _parseInt(dynamic number, [int defaultValue = 0]) {
      if (number is int) return number;
      if (number is String) return int.tryParse(number) ?? defaultValue;
      return defaultValue;
    }

    try {
      // Manejo del contenido
      final contentData = json['content'];
      final Content content;

      if (contentData is String) {
        content = Content(
          introduction: contentData,
          learningObjectives: LearningObjectives.fromJson({}),
          keyConcepts: KeyConcepts.fromJson({}),
          activities: Activities.fromJson({}),
          conclusion: '',
          additionalResources: [],
        );
      } else if (contentData is Map<String, dynamic>) {
        content = Content.fromJson(contentData);
      } else {
        content = Content.fromJson({});
      }

      // Parseo de recursos relacionados
      final relatedResources = <ResourceReference>[];
      if (json['relatedResources'] is List) {
        for (final item in json['relatedResources'] as List) {
          try {
            if (item is Map<String, dynamic>) {
              relatedResources.add(ResourceReference.fromJson(item));
            }
          } catch (e) {
            print('Error parsing related resource: $e');
          }
        }
      }

      return EducationalResource(
        id: json['_id']?.toString() ?? '',
        title: json['title']?.toString() ?? 'Sin título',
        summary: json['summary']?.toString() ?? '',
        content: content,
        imageUrl: json['imageUrl']?.toString() ?? '',
        galleryImages: _parseStringList(json['galleryImages']),
        author: json['author']?.toString() ?? 'Autor desconocido',
        publishDate: _parseDateTime(json['publishDate']),
        lastUpdate: _parseDateTime(json['lastUpdate']),
        tags: _parseStringList(json['tags']),
        estimatedTime: _parseInt(json['estimatedTime'], 30),
        isFeatured: json['isFeatured'] == true,
        subject: json['subject']?.toString() ?? 'General',
        educationalLevel: json['educationalLevel']?.toString() ?? 'Todos los niveles',
        views: _parseInt(json['views']),
        relatedResources: relatedResources,
      );
    } catch (e, stackTrace) {
      print('Error parsing EducationalResource: $e');
      print('Stack trace: $stackTrace');
      
      return EducationalResource(
        id: '',
        title: 'Error parsing data',
        summary: '',
        content: Content.fromJson({}),
        imageUrl: '',
        author: '',
        publishDate: DateTime.now(),
        lastUpdate: DateTime.now(),
        estimatedTime: 30,
        subject: 'Error',
        educationalLevel: 'Todos los niveles',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'summary': summary,
      'content': content.toJson(),
      'imageUrl': imageUrl,
      'galleryImages': galleryImages,
      'author': author,
      'publishDate': publishDate.toIso8601String(),
      'lastUpdate': lastUpdate.toIso8601String(),
      'tags': tags,
      'estimatedTime': estimatedTime,
      'isFeatured': isFeatured,
      'subject': subject,
      'educationalLevel': educationalLevel,
      'views': views,
      'relatedResources': relatedResources.map((x) => x.toJson()).toList(),
    };
  }
}

class Content {
  final String introduction;
  final LearningObjectives learningObjectives;
  final KeyConcepts keyConcepts;
  final Activities activities;
  final String conclusion;
  final List<String> additionalResources;

  Content({
    required this.introduction,
    required this.learningObjectives,
    required this.keyConcepts,
    required this.activities,
    required this.conclusion,
    this.additionalResources = const [],
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      introduction: json['introduction']?.toString() ?? '',
      learningObjectives: LearningObjectives.fromJson(json['learning_objectives'] ?? {}),
      keyConcepts: KeyConcepts.fromJson(json['key_concepts'] ?? {}),
      activities: Activities.fromJson(json['activities'] ?? {}),
      conclusion: json['conclusion']?.toString() ?? '',
      additionalResources: (json['additional_resources'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'introduction': introduction,
      'learning_objectives': learningObjectives.toJson(),
      'key_concepts': keyConcepts.toJson(),
      'activities': activities.toJson(),
      'conclusion': conclusion,
      'additional_resources': additionalResources,
    };
  }
}

class LearningObjectives {
  final List<String> knowledgeObjectives;
  final List<String> skillObjectives;
  final List<String> attitudeObjectives;

  LearningObjectives({
    this.knowledgeObjectives = const [],
    this.skillObjectives = const [],
    this.attitudeObjectives = const [],
  });

  factory LearningObjectives.fromJson(Map<String, dynamic> json) {
    return LearningObjectives(
      knowledgeObjectives: (json['knowledge_objectives'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      skillObjectives: (json['skill_objectives'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      attitudeObjectives: (json['attitude_objectives'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'knowledge_objectives': knowledgeObjectives,
      'skill_objectives': skillObjectives,
      'attitude_objectives': attitudeObjectives,
    };
  }
}

class KeyConcepts {
  final String mainConcept;
  final List<String> secondaryConcepts;
  final List<String> vocabulary;

  KeyConcepts({
    required this.mainConcept,
    this.secondaryConcepts = const [],
    this.vocabulary = const [],
  });

  factory KeyConcepts.fromJson(Map<String, dynamic> json) {
    return KeyConcepts(
      mainConcept: json['main_concept']?.toString() ?? '',
      secondaryConcepts: (json['secondary_concepts'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      vocabulary: (json['vocabulary'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main_concept': mainConcept,
      'secondary_concepts': secondaryConcepts,
      'vocabulary': vocabulary,
    };
  }
}

class Activities {
  final List<Activity> introductoryActivities;
  final List<Activity> developmentActivities;
  final List<Activity> evaluationActivities;
  final List<Activity> extensionActivities;

  Activities({
    this.introductoryActivities = const [],
    this.developmentActivities = const [],
    this.evaluationActivities = const [],
    this.extensionActivities = const [],
  });

  factory Activities.fromJson(Map<String, dynamic> json) {
    return Activities(
      introductoryActivities: (json['introductory_activities'] as List<dynamic>?)
          ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      developmentActivities: (json['development_activities'] as List<dynamic>?)
          ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      evaluationActivities: (json['evaluation_activities'] as List<dynamic>?)
          ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      extensionActivities: (json['extension_activities'] as List<dynamic>?)
          ?.map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'introductory_activities': introductoryActivities.map((e) => e.toJson()).toList(),
      'development_activities': developmentActivities.map((e) => e.toJson()).toList(),
      'evaluation_activities': evaluationActivities.map((e) => e.toJson()).toList(),
      'extension_activities': extensionActivities.map((e) => e.toJson()).toList(),
    };
  }
}

class Activity {
  final String title;
  final String description;
  final String instructions;
  final String duration; // e.g., "30 minutos"
  final List<String> materials;
  final String evaluationCriteria;

  Activity({
    required this.title,
    required this.description,
    required this.instructions,
    required this.duration,
    this.materials = const [],
    this.evaluationCriteria = '',
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      instructions: json['instructions']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '30 minutos',
      materials: (json['materials'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      evaluationCriteria: json['evaluation_criteria']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'instructions': instructions,
      'duration': duration,
      'materials': materials,
      'evaluation_criteria': evaluationCriteria,
    };
  }
}

class ResourceReference {
  final String id;
  final String title;
  final String imageUrl;
  final String resourceType; // e.g., "video", "worksheet", "lesson_plan"

  ResourceReference({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.resourceType,
  });

  factory ResourceReference.fromJson(Map<String, dynamic> json) {
    return ResourceReference(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      resourceType: json['resourceType']?.toString() ?? 'lesson_plan',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'imageUrl': imageUrl,
      'resourceType': resourceType,
    };
  }
}