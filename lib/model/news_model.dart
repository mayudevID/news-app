class NewsModel {
  NewsModel({
    required this.message,
    required this.total,
    required this.data,
  });

  final String? message;
  final int? total;
  final List<Datum> data;

  NewsModel copyWith({
    String? message,
    int? total,
    List<Datum>? data,
  }) {
    return NewsModel(
      message: message ?? this.message,
      total: total ?? this.total,
      data: data ?? this.data,
    );
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      message: json["message"],
      total: json["total"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "total": total,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  Datum({
    required this.title,
    required this.link,
    required this.isoDate,
    required this.image,
    required this.description,
  });

  final String? title;
  final String? link;
  final DateTime? isoDate;
  final String? image;
  final String? description;

  Datum copyWith({
    String? title,
    String? link,
    DateTime? isoDate,
    String? image,
    String? description,
  }) {
    return Datum(
      title: title ?? this.title,
      link: link ?? this.link,
      isoDate: isoDate ?? this.isoDate,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      title: json["title"],
      link: json["link"],
      isoDate: DateTime.tryParse(json["isoDate"] ?? ""),
      image: json["image"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "isoDate": isoDate?.toIso8601String(),
        "image": image,
        "description": description,
      };
}
