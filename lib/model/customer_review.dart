class CustomerReview {
  final String? id;
  final String name;
  final String review;
  final String? date;

  CustomerReview({
    this.id = '',
    required this.name,
    required this.review,
    this.date = '',
  });

  factory CustomerReview.fromJson(Map<String, dynamic> review) =>
      CustomerReview(
        id: review['id'] ?? '',
        name: review['name'],
        review: review['review'],
        date: review['date'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
        "date": date,
      };
}

class ResponseCustomerReview {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  ResponseCustomerReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ResponseCustomerReview.fromJson(Map<String, dynamic> json) =>
      ResponseCustomerReview(
          error: json["error"],
          message: json["message"],
          customerReviews: List<CustomerReview>.from(json["customerReviews"]
              .map((item) => CustomerReview.fromJson(item))));
}
