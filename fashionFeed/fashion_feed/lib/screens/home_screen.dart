import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recommendations.dart';
import '../models/wishlist.dart';

class RecommendationTile extends StatelessWidget {
  final Recommendation recommendation;
  final VoidCallback onWishlistAdd;

  const RecommendationTile({Key? key, required this.recommendation, required this.onWishlistAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590, // Set a fixed width for the card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: AspectRatio(
                aspectRatio: 0.85, // Adjust as needed
                child: Image.network(
                  recommendation.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recommendation.item,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    recommendation.brand,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${recommendation.price}',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border, color: Colors.pink, size: 30.0),
                            onPressed: onWishlistAdd,
                          ),
                          IconButton(
                            icon: Icon(Icons.shopping_bag_outlined, color: Colors.pink, size: 30.0),
                            onPressed: () {
                              // Handle bag functionality
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
