import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myntra_techwiz/product/product_screen.dart';

class ProfileScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            const Icon(
              Icons.wallet,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/Discount.png',
              width: 30,
            ),
            const SizedBox(
              width: 10,
            )
          ],
          title: Text(
            'My Fashion Profile',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/Woman.png"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Basics',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          'Insider',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          'Orders',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          'Size details',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          'Skin and Hair',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          'Daily Rewards',
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                color: const Color(0xFFEEC6EF),
                child: Center(
                    child: Text(
                  " My Best Buys",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      for (var i = 1; i <= 6; i++)
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Image.asset(
                                      'assets/image$i.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/image$i.png'),
                            radius: 40,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductScreen(
                          brand: 'Brand Name',
                          productName: 'U.S.Polo Cotton T-shirt',
                          price: '1,192',
                          imageUrl: ["Screenshot 2024-07-14 151553", "p1", "p2"],
                          discountedPrice: '1,500',
                          discountPercent: 23,
                        ),
                      ),
                    ),
                    child: Image.asset(
                      'assets/Screenshot 2024-07-14 151553.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductScreen(
                                  brand: 'Leopard',
                                  productName: '',
                                  price: '',
                                  imageUrl: ['assets/image2.png'],
                                  discountedPrice: '',
                                  discountPercent: 0,
                                ))),
                    child: Image.asset(
                      'assets/image2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductScreen(
                                  brand: '',
                                  productName: '',
                                  price: '',
                                  imageUrl: [],
                                  discountedPrice: '',
                                  discountPercent: 0,
                                ))),
                    child: Image.asset(
                      'assets/image3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductScreen(
                                  brand: '',
                                  productName: '',
                                  price: '',
                                  imageUrl: [],
                                  discountedPrice: '',
                                  discountPercent: 0,
                                ))),
                    child: Image.asset(
                      'assets/image4.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductScreen(
                                  brand: '',
                                  productName: '',
                                  price: '',
                                  imageUrl: [],
                                  discountedPrice: '',
                                  discountPercent: 0,
                                ))),
                    child: Image.asset(
                      'assets/image5.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductScreen(
                                  brand: '',
                                  productName: '',
                                  price: '',
                                  imageUrl: [],
                                  discountedPrice: '',
                                  discountPercent: 0,
                                ))),
                    child: Image.asset(
                      'assets/image6.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
