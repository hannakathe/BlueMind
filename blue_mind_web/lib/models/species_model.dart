class PhysicalCharacteristics {
  final String length;
  final String weight;
  final String coloration;
  final String lifespan;

  PhysicalCharacteristics({
    required this.length,
    required this.weight,
    required this.coloration,
    required this.lifespan,
  });

  factory PhysicalCharacteristics.fromJson(Map<String, dynamic> json) {
    return PhysicalCharacteristics(
      length: json['length'] ?? '',
      weight: json['weight'] ?? '',
      coloration: json['coloration'] ?? '',
      lifespan: json['lifespan'] ?? '',
    );
  }
}

class Behavior {
  final String socialStructure;
  final String communication;
  final String intelligence;
  final String playfulness;

  Behavior({
    required this.socialStructure,
    required this.communication,
    required this.intelligence,
    required this.playfulness,
  });

  factory Behavior.fromJson(Map<String, dynamic> json) {
    return Behavior(
      socialStructure: json['socialStructure'] ?? '',
      communication: json['communication'] ?? '',
      intelligence: json['intelligence'] ?? '',
      playfulness: json['playfulness'] ?? '',
    );
  }
}

class DietAndFeeding {
  final String feedingHabits;
  final String huntingTechniques;
  final String dailyConsumption;

  DietAndFeeding({
    required this.feedingHabits,
    required this.huntingTechniques,
    required this.dailyConsumption,
  });

  factory DietAndFeeding.fromJson(Map<String, dynamic> json) {
    return DietAndFeeding(
      feedingHabits: json['feedingHabits'] ?? '',
      huntingTechniques: json['huntingTechniques'] ?? '',
      dailyConsumption: json['dailyConsumption'] ?? '',
    );
  }
}

class Reproduction {
  final String gestation;
  final String calves;
  final String nursingPeriod;
  final String maturity;

  Reproduction({
    required this.gestation,
    required this.calves,
    required this.nursingPeriod,
    required this.maturity,
  });

  factory Reproduction.fromJson(Map<String, dynamic> json) {
    return Reproduction(
      gestation: json['gestation'] ?? '',
      calves: json['calves'] ?? '',
      nursingPeriod: json['nursingPeriod'] ?? '',
      maturity: json['maturity'] ?? '',
    );
  }
}

class Predators {
  final List<String> naturalPredators;
  final List<String> threatsFromHumans;

  Predators({
    required this.naturalPredators,
    required this.threatsFromHumans,
  });

  factory Predators.fromJson(Map<String, dynamic> json) {
    return Predators(
      naturalPredators: (json['naturalPredators'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      threatsFromHumans: (json['threatsFromHumans'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class ConservationEfforts {
  final String legalProtection;
  final String researchAndMonitoring;
  final String marineProtectedAreas;

  ConservationEfforts({
    required this.legalProtection,
    required this.researchAndMonitoring,
    required this.marineProtectedAreas,
  });

  factory ConservationEfforts.fromJson(Map<String, dynamic> json) {
    return ConservationEfforts(
      legalProtection: json['legalProtection'] ?? '',
      researchAndMonitoring: json['researchAndMonitoring'] ?? '',
      marineProtectedAreas: json['marineProtectedAreas'] ?? '',
    );
  }
}

class Especie {
  final String id;
  final String commonName;
  final String scientificName;
  final String family;
  final String mainImage;
  final List<String> images;
  final String conservationStatus;
  final String habitat;
  final String distribution;
  final String description;
  final List<String> characteristics;
  final PhysicalCharacteristics physicalCharacteristics;
  final Behavior behavior;
  final DietAndFeeding dietAndFeeding;
  final Reproduction reproduction;
  final Predators predators;
  final ConservationEfforts conservationEfforts;
  final List<String> funFacts;

  Especie({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.family,
    required this.mainImage,
    required this.images,
    required this.conservationStatus,
    required this.habitat,
    required this.distribution,
    required this.description,
    required this.characteristics,
    required this.physicalCharacteristics,
    required this.behavior,
    required this.dietAndFeeding,
    required this.reproduction,
    required this.predators,
    required this.conservationEfforts,
    required this.funFacts,
  });

  factory Especie.fromJson(Map<String, dynamic> json) {
    return Especie(
      id: json['id'] ?? '',
      commonName: json['commonName'] ?? '',
      scientificName: json['scientificName'] ?? '',
      family: json['family'] ?? '',
      mainImage: json['mainImage'] ?? '',
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      conservationStatus: json['conservationStatus'] ?? '',
      habitat: json['habitat'] ?? '',
      distribution: json['distribution'] ?? '',
      description: json['description'] ?? '',
      characteristics: (json['characteristics'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      physicalCharacteristics: PhysicalCharacteristics.fromJson(json['physicalCharacteristics'] ?? {}),
      behavior: Behavior.fromJson(json['behavior'] ?? {}),
      dietAndFeeding: DietAndFeeding.fromJson(json['dietAndFeeding'] ?? {}),
      reproduction: Reproduction.fromJson(json['reproduction'] ?? {}),
      predators: Predators.fromJson(json['predators'] ?? {}),
      conservationEfforts: ConservationEfforts.fromJson(json['conservationEfforts'] ?? {}),
      funFacts: (json['funFacts'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}