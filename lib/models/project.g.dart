// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
  id: json['id'] as String?,
  title: json['title'] as String,
  description: json['description'] as String,
  event: json['event'] as String? ?? '',
  year: (json['year'] as num?)?.toInt() ?? 0,
  coverImage: json['cover_image'] as String? ?? '',
  projectUrl: json['project_url'] as String,
  createdAt: json['created_at'] as String? ?? '',
  starCount: (json['star_count'] as num?)?.toInt() ?? 0,
  isStarred: json['is_starred'] as bool? ?? false,
  starredByNames: json['starred_by_names'] as String? ?? '',
  techStack: json['tech_stack'] as String? ?? '',
  projectImageUrl: json['project_image_url'] as String? ?? '',
);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'event': instance.event,
  'year': instance.year,
  'cover_image': instance.coverImage,
  'project_url': instance.projectUrl,
  'created_at': instance.createdAt,
  'star_count': instance.starCount,
  'is_starred': instance.isStarred,
  'starred_by_names': instance.starredByNames,
  'tech_stack': instance.techStack,
  'project_image_url': instance.projectImageUrl,
};
