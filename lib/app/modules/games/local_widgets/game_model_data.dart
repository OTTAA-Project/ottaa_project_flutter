class GameModelData {
  GameModelData({
    required this.title,
    required this.subtitle,
    required this.completedNumber,
    required this.totalLevel,
    required this.imageAsset,
  });

  int totalLevel, completedNumber;
  final String title, subtitle, imageAsset;
}
