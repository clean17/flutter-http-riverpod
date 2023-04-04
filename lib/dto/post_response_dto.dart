class PostDto {
  int id;
  String title;

  PostDto({required this.id, required this.title});

  factory PostDto.fromJson(Map<String, dynamic> json) => PostDto(
      id: json["id"],
      title: json["title"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title
  };
}