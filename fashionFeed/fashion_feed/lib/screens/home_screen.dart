import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recommendations.dart';
import '../models/wishlist.dart';

class RecommendationTile extends StatefulWidget {
  final Recommendation recommendation;
  final Function(WishlistItem) onWishlistToggle;
  final bool isInitiallyWishlisted;

  const RecommendationTile({
    Key? key,
    required this.recommendation,
    required this.onWishlistToggle,
    required this.isInitiallyWishlisted,
  }) : super(key: key);

  @override
  _RecommendationTileState createState() => _RecommendationTileState();
}

class _RecommendationTileState extends State<RecommendationTile> {
  late bool isWishlisted;

  @override
  void initState(){
    super.initState();
    isWishlisted = widget.isInitiallyWishlisted;
  }

  void toggleWishlist() {
    final wishlistItem = WishlistItem(
      id: widget.recommendation.id,
      brand: widget.recommendation.brand,
      item: widget.recommendation.item,
      price: widget.recommendation.price,
      image: widget.recommendation.image,
    );

    setState(() {
      isWishlisted = !isWishlisted;
    });

    widget.onWishlistToggle(wishlistItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590, // Set a fixed height for the card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: AspectRatio(
                aspectRatio: 0.85, // Adjust as needed
                child: Image.network(
                  widget.recommendation.image,
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
                    widget.recommendation.item,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.recommendation.brand,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${widget.recommendation.price}',
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
                            icon: Icon(
                              isWishlisted ? Icons.favorite : Icons.favorite_border,
                              color: Colors.pink,
                              size: 30.0,
                            ),
                            onPressed: toggleWishlist,
                          ),
                          IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.pink, size: 30.0),
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
