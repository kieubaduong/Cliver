import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  int? id;
  String? title;
  String? description;
  String? userId;
  String? status;
  User? user;
  int? subcategoryId;
  Category? category;
  List<String>? tags;
  List<String>? images;
  String? video;
  String? document;
  bool? isSaved;
  bool? hasOfferPackages;
  List<Package>? packages;
  String? createdAt;
  String? updatedAt;
  double? ratingAvg;
  int? ratingCount;
  int? minPrice;
  String? message;
  bool? isPublish;

  Post(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.title,
      this.description,
      this.userId,
      this.status,
      this.subcategoryId,
      this.category,
      this.tags,
      this.images,
      this.video,
      this.document,
      this.isSaved,
      this.user,
      this.hasOfferPackages,
      this.packages,
      this.message,
      this.ratingAvg,
      this.ratingCount,
      this.minPrice,
      this.isPublish});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

class MetaData {
  int? offset;
  int? limit;
  int? count;
  int? totalCount;

  MetaData({this.offset, this.limit, this.count, this.totalCount});

  MetaData.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    count = json['count'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['limit'] = limit;
    data['count'] = count;
    data['totalCount'] = totalCount;
    return data;
  }
}
