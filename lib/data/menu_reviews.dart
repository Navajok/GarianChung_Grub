import 'package:mad_project_test/profile/profile.dart';

/// Represents a single review for a food outlet
class Review {
  final AppUser user;
  final String text;
  final String rating; 

  Review({
    required this.user,
    required this.text,
    required this.rating,
  });
}

/// Manages all reviews for all outlets
class ReviewRecords {
  static final Map<String, List<Review>> _reviewsByOutlet = {};

  /// Get reviews for a specific outlet
  static List<Review> getReviews(String outletName) {
    return _reviewsByOutlet[outletName] ?? [];
  }

  /// Add a review for a specific outlet
  static void addReview(String outletName, Review review) {
    _reviewsByOutlet.putIfAbsent(outletName, () => []);
    _reviewsByOutlet[outletName]!.add(review);
  }
}
