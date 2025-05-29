// models/blog_model.dart

class BlogDocument {
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
  final int readTime; // in minutes
  final bool isFeatured;
  final String category;
  final int views;
  final List<DocumentReference> relatedDocuments;

  BlogDocument({
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
    required this.readTime,
    this.isFeatured = false,
    required this.category,
    this.views = 0,
    this.relatedDocuments = const [],
  });

  factory BlogDocument.fromJson(Map<String, dynamic> json) {
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
        introduccion: contentData,
        causasDelDeterioro: Causes.fromJson({}),
        consecuenciasDelDeterioro: Consequences.fromJson({}),
        solucionesYStrategias: Solutions.fromJson({}),
        conclusion: '',
        fuentesRecomendadas: [],
      );
    } else if (contentData is Map<String, dynamic>) {
      content = Content.fromJson(contentData);
    } else {
      content = Content.fromJson({});
    }

    // Parseo de documentos relacionados
    final relatedDocs = <DocumentReference>[];
    if (json['relatedDocuments'] is List) {
      for (final item in json['relatedDocuments'] as List) {
        try {
          if (item is Map<String, dynamic>) {
            relatedDocs.add(DocumentReference.fromJson(item));
          }
        } catch (e) {
          print('Error parsing related document: $e');
        }
      }
    }

    return BlogDocument(
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
      readTime: _parseInt(json['readTime'], 5),
      isFeatured: json['isFeatured'] == true,
      category: json['category']?.toString() ?? 'General',
      views: _parseInt(json['views']),
      relatedDocuments: relatedDocs,
    );
  } catch (e, stackTrace) {
    print('Error parsing BlogDocument: $e');
    print('Stack trace: $stackTrace');
    
    return BlogDocument(
      id: '',
      title: 'Error parsing data',
      summary: '',
      content: Content.fromJson({}),
      imageUrl: '',
      author: '',
      publishDate: DateTime.now(),
      lastUpdate: DateTime.now(),
      readTime: 5,
      category: 'Error',
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
      'readTime': readTime,
      'isFeatured': isFeatured,
      'category': category,
      'views': views,
      'relatedDocuments': relatedDocuments.map((x) => x.toJson()).toList(),
    };
  }
}

class Content {
  final String introduccion;
  final Causes causasDelDeterioro;
  final Consequences consecuenciasDelDeterioro;
  final Solutions solucionesYStrategias;
  final String conclusion;
  final List<String> fuentesRecomendadas;

  Content({
    required this.introduccion,
    required this.causasDelDeterioro,
    required this.consecuenciasDelDeterioro,
    required this.solucionesYStrategias,
    required this.conclusion,
    this.fuentesRecomendadas = const [],
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      introduccion: json['introduccion']?.toString() ?? '',
      causasDelDeterioro: Causes.fromJson(json['causas_del_deterioro'] ?? {}),
      consecuenciasDelDeterioro: Consequences.fromJson(json['consecuencias_del_deterioro'] ?? {}),
      solucionesYStrategias: Solutions.fromJson(json['soluciones_y_estrategias'] ?? {}),
      conclusion: json['conclusion']?.toString() ?? '',
      fuentesRecomendadas: (json['fuentes_recomendadas'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'introduccion': introduccion,
      'causas_del_deterioro': causasDelDeterioro.toJson(),
      'consecuencias_del_deterioro': consecuenciasDelDeterioro.toJson(),
      'soluciones_y_estrategias': solucionesYStrategias.toJson(),
      'conclusion': conclusion,
      'fuentes_recomendadas': fuentesRecomendadas,
    };
  }
}

class Causes {
  final TemperatureIncrease aumentoTemperaturaMar;
  final OceanAcidification acidificacionOceanica;
  final ExtremeWeather fenomenosMeteorologicosExtremos;
  final List<String> otrasAmenazas;

  Causes({
    required this.aumentoTemperaturaMar,
    required this.acidificacionOceanica,
    required this.fenomenosMeteorologicosExtremos,
    this.otrasAmenazas = const [],
  });

  factory Causes.fromJson(Map<String, dynamic> json) {
    return Causes(
      aumentoTemperaturaMar: TemperatureIncrease.fromJson(json['aumento_temperatura_mar'] ?? {}),
      acidificacionOceanica: OceanAcidification.fromJson(json['acidificacion_oceanica'] ?? {}),
      fenomenosMeteorologicosExtremos: ExtremeWeather.fromJson(json['fenomenos_meteorologicos_extremos'] ?? {}),
      otrasAmenazas: (json['otras_amenazas'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aumento_temperatura_mar': aumentoTemperaturaMar.toJson(),
      'acidificacion_oceanica': acidificacionOceanica.toJson(),
      'fenomenos_meteorologicos_extremos': fenomenosMeteorologicosExtremos.toJson(),
      'otras_amenazas': otrasAmenazas,
    };
  }
}

class TemperatureIncrease {
  final String descripcion;
  final List<String> efectos;

  TemperatureIncrease({
    required this.descripcion,
    this.efectos = const [],
  });

  factory TemperatureIncrease.fromJson(Map<String, dynamic> json) {
    return TemperatureIncrease(
      descripcion: json['descripcion']?.toString() ?? '',
      efectos: (json['efectos'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'efectos': efectos,
    };
  }
}

class OceanAcidification {
  final String descripcion;
  final List<String> efectos;

  OceanAcidification({
    required this.descripcion,
    this.efectos = const [],
  });

  factory OceanAcidification.fromJson(Map<String, dynamic> json) {
    return OceanAcidification(
      descripcion: json['descripcion']?.toString() ?? '',
      efectos: (json['efectos'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'efectos': efectos,
    };
  }
}

class ExtremeWeather {
  final String descripcion;
  final List<String> efectos;

  ExtremeWeather({
    required this.descripcion,
    this.efectos = const [],
  });

  factory ExtremeWeather.fromJson(Map<String, dynamic> json) {
    return ExtremeWeather(
      descripcion: json['descripcion']?.toString() ?? '',
      efectos: (json['efectos'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'efectos': efectos,
    };
  }
}

class Consequences {
  final String perdidaBiodiversidad;
  final EconomicImpact impactoEconomico;
  final CoastalRisk aumentoRiesgoCostero;

  Consequences({
    required this.perdidaBiodiversidad,
    required this.impactoEconomico,
    required this.aumentoRiesgoCostero,
  });

  factory Consequences.fromJson(Map<String, dynamic> json) {
    return Consequences(
      perdidaBiodiversidad: json['perdida_biodiversidad']?.toString() ?? '',
      impactoEconomico: EconomicImpact.fromJson(json['impacto_economico'] ?? {}),
      aumentoRiesgoCostero: CoastalRisk.fromJson(json['aumento_riesgo_costero'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'perdida_biodiversidad': perdidaBiodiversidad,
      'impacto_economico': impactoEconomico.toJson(),
      'aumento_riesgo_costero': aumentoRiesgoCostero.toJson(),
    };
  }
}

class EconomicImpact {
  final String descripcion;
  final String efectos;

  EconomicImpact({
    required this.descripcion,
    required this.efectos,
  });

  factory EconomicImpact.fromJson(Map<String, dynamic> json) {
    return EconomicImpact(
      descripcion: json['descripcion']?.toString() ?? '',
      efectos: json['efectos']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'efectos': efectos,
    };
  }
}

class CoastalRisk {
  final String descripcion;
  final String efectos;

  CoastalRisk({
    required this.descripcion,
    required this.efectos,
  });

  factory CoastalRisk.fromJson(Map<String, dynamic> json) {
    return CoastalRisk(
      descripcion: json['descripcion']?.toString() ?? '',
      efectos: json['efectos']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descripcion': descripcion,
      'efectos': efectos,
    };
  }
}

class Solutions {
  final List<String> mitigacionCambioClimatico;
  final List<String> proteccionRestauracion;
  final List<String> investigacionMonitoreo;

  Solutions({
    this.mitigacionCambioClimatico = const [],
    this.proteccionRestauracion = const [],
    this.investigacionMonitoreo = const [],
  });

  factory Solutions.fromJson(Map<String, dynamic> json) {
    return Solutions(
      mitigacionCambioClimatico: (json['mitigacion_cambio_climatico'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      proteccionRestauracion: (json['proteccion_restauracion'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      investigacionMonitoreo: (json['investigacion_monitoreo'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mitigacion_cambio_climatico': mitigacionCambioClimatico,
      'proteccion_restauracion': proteccionRestauracion,
      'investigacion_monitoreo': investigacionMonitoreo,
    };
  }
}

class DocumentReference {
  final String id;
  final String title;
  final String imageUrl;

  DocumentReference({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory DocumentReference.fromJson(Map<String, dynamic> json) {
    return DocumentReference(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}