import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController = TextEditingController();
  final VoidCallback onWishlistPress;

  CustomHeader({Key? key, required this.onWishlistPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: kToolbarHeight - 20,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.lato(), // Apply custom font here
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromARGB(255, 255, 231, 252),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            suffixIcon: IconButton(
              icon: Icon(Icons.search, color: Colors.pink),
              onPressed: () {
                // Handle search functionality
              },
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.pink, size: 30.0,),
          onPressed: onWishlistPress,
        ),
        IconButton(
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.pink, size: 30.0,),
          onPressed: () {
            // Handle bag functionality
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
