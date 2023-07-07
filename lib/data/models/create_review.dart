import 'dart:convert';

class CreateReview {
  int? orderId;
  int? rating;
  String? comment;
  int? label;
  CreateReview({
    this.orderId,
    this.rating,
    this.comment,
    this.label,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'rating': rating,
      'comment': comment,
      'label' : label,
    };
  }

  factory CreateReview.fromMap(Map<String, dynamic> map) {
    return CreateReview(
      orderId: map['orderId']?.toInt(),
      rating: map['rating']?.toInt(),
      comment: map['comment'],
      label: map['label']?.toInt()
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateReview.fromJson(String source) =>
      CreateReview.fromMap(json.decode(source));
}
