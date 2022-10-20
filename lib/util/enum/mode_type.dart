enum ModeType { cosmetic, bags, pets, others }

extension ModeTypeExtension on ModeType {
  String get string {
    switch (this) {
      case ModeType.cosmetic:
        return 'cosmetic';
      case ModeType.bags:
        return 'bags';
      case ModeType.pets:
        return 'pets';
      case ModeType.others:
        return 'others';
    }
  }
}
