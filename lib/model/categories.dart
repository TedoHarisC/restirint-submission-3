class Categories {
  final String name;

  Categories({
    this.name = '',
  });

  factory Categories.fromJson(Map<String, dynamic> category) => Categories(
        name: category['name'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
