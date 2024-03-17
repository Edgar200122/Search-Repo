class Repository {
  final String fullName;
  final String? description;

  Repository({
    required this.fullName,
    this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      fullName: json['full_name'],
      description: json['description'],
    );
  }
}
