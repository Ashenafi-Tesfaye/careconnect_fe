class AchievementModel {
  final String title;
  final String description;
  final bool unlocked;

  AchievementModel({
    required this.title,
    required this.description,
    this.unlocked = false,
  });
}
