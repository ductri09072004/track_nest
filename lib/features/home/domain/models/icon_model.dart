class IconModel {
  final String name;
  final String icon;

  IconModel({required this.name, required this.icon});

  factory IconModel.fromJson(Map<String, dynamic> json) {
    return IconModel(
      name: json['name'] as String,
      icon: json['icon'] as String,
    );
  }
}
