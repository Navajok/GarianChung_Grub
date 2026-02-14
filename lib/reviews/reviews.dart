import 'package:flutter/material.dart';
import 'package:mad_project_test/profile/profile.dart';
import 'package:mad_project_test/data/menu_reviews.dart';

class ReviewsSection extends StatefulWidget {
  final String outletName;

  const ReviewsSection({super.key, required this.outletName});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final _controller = TextEditingController();
  int _selectedStars = 5;

  void submitReview() {
    final user = Profile.currentUser!;

    if (_controller.text.isNotEmpty) {
      ReviewRecords.addReview(
        widget.outletName,
        Review(
          user: user,
          text: _controller.text,
          rating: _selectedStars.toString(),
        ),
      );

      _controller.clear();

      setState(() {
        _selectedStars = 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviews = ReviewRecords.getReviews(widget.outletName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        if (reviews.isEmpty)
          const Text(
            "No reviews yet. Be the first!",
            style: TextStyle(color: Colors.grey),
          )
        else
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];

                return Container(
                  width: 220,
                  margin: const EdgeInsets.only(right: 12),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: List.generate(
                              int.tryParse(review.rating)!,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              review.text,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        const SizedBox(height: 20),

        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Write a review...',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: List.generate(
            5,
            (index) => IconButton(
              icon: Icon(
                index < _selectedStars ? Icons.star : Icons.star_border,
                color: Colors.orange,
              ),
              onPressed: () {
                setState(() {
                  _selectedStars = index + 1;
                });
              },
            ),
          ),
        ),

        ElevatedButton(
          onPressed: submitReview,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
