import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.title,
    required this.description,
    this.event = '',
    this.year = 0,
    this.coverImage = '',
    required this.projectUrl,
    this.createdAt = '',
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
    this.techStack = '',
    this.projectImageUrl = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;

  @JsonKey(defaultValue: '')
  final String event;

  @JsonKey(defaultValue: 0)
  final int year;

  @JsonKey(defaultValue: '')
  final String coverImage;

  final String projectUrl;

  @JsonKey(defaultValue: '')
  final String createdAt;

  @JsonKey(defaultValue: 0)
  final int starCount;

  @JsonKey(defaultValue: false)
  final bool isStarred;

  @JsonKey(defaultValue: '')
  final String starredByNames;

  @JsonKey(defaultValue: '')
  final String techStack;

  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
