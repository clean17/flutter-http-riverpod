class HomePagePostDto {
  int? id;
  String? title;

  HomePagePostDto({this.id, this.title});

  factory HomePagePostDto.fromJson(Map<String, dynamic> json) => HomePagePostDto(
      id: json["id"],
      title: json["title"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title
  };
}