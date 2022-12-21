// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'album.g.dart';
@JsonSerializable()
class Album {
  final int id;
  final String title;
  Album({
    required this.id,
    required this.title,
  });
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
