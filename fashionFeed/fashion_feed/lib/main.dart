import 'dart:convert';
import 'package:fashion_feed/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/models/recommendations.dart';
import '/screens/header.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/wishlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)
      ),
      home: RecommendationScreen(),
    );
  }
}



class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late Future<List<Recommendation>> recommendations;
  final List<WishlistItem> wishlist = [];

  @override
  void initState() {
    super.initState();
    recommendations = fetchRecommendations();
  }

  Future<List<Recommendation>> fetchRecommendations() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/recommendations')); // Flask URL
    
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Recommendation.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load recommendations');
    }
  }

  void handleWishlist(WishlistItem item){
    setState(() {
      if(wishlist.contains(item)){
        wishlist.remove(item);
      } else{
        wishlist.add(item);
      }
    });
  }
  void showWishlist() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Wishlist'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final item = wishlist[index];
                return ListTile(
                  leading: Image.network(item.image),
                  title: Text(item.item),
                  subtitle: Text('Price: ₹${item.price}'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(onWishlistPress: showWishlist,),
      body: FutureBuilder<List<Recommendation>>(
        future: recommendations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recommendation = snapshot.data![index];
                return RecommendationTile(recommendation: recommendation,
                onWishlistAdd: () {
                    handleWishlist(WishlistItem(
                      id: recommendation.id,
                      image: recommendation.image,
                      item: recommendation.item,
                      brand: recommendation.brand,
                      price: recommendation.price,
                    ));
                  },);
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.auto_awesome_sharp, color: Colors.pink, size: 37.0,),
              onPressed: (){

              },
              ),
            IconButton(
            icon: Icon(Icons.face, color: Colors.pink,size: 37.0,),
            onPressed: (){

            },
            ),
            IconButton(
              icon: Icon(Icons.home, color: Colors.pink, size: 37.0,),
              onPressed: () {
                // Home button action
              },
            ),
            IconButton(
              icon: Icon(Icons.auto_graph, color: Colors.pink, size: 37.0,),
              onPressed: () {
                // Home button action
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.pink, size: 37.0,),
              onPressed: () {
                // Profile button action
              },
            ),
          ],
        ),
      ),
    );
  }
}
