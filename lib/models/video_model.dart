// Generated by https://quicktype.io

class VideoModel {
  String? iso_639_1;
  String? iso_3166_1;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? published_at;
  String? id;

  VideoModel({
    this.iso_639_1,
    this.iso_3166_1,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.published_at,
    this.id,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      iso_639_1: map['iso_639_1'],
      iso_3166_1: map['iso_3166_1'],
      name: map['name'],
      key: map['key'] as String,
      site: map['site'],
      size: map['size'],
      type: map['type'],
      official: map['official'],
      published_at: map['published_at'],
      id: map['id'],
    );
  }
}
