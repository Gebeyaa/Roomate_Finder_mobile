import 'package:flutter/material.dart';

class HomePageDetailScreen extends StatefulWidget {
  const HomePageDetailScreen({Key? key}) : super(key: key);

  @override
  State<HomePageDetailScreen> createState() => _HomePageDetailScreenState();
}

class _HomePageDetailScreenState extends State<HomePageDetailScreen> {
  bool isFavorite = false;

  final String houseTitle = "2BHK Apartment for Rent";
  final String houseLocation = "Indiranagar, Bengaluru";
  final String housePrice = "₹18,000/month";
  final String houseImage = "images/telegram.png";
  final String ownerPhone = "+251 9876543210";
  final String ownerMessage = "Message Owner";
  final String houseShortDescription =
      "Spacious and well-lit 2BHK apartment available for rent in the heart of Indiranagar. Close to metro, supermarkets, and restaurants. Ideal for working professionals or small families.";
  final String houseMoreInfo =
      "More Information:\n\n- 2 Bedrooms, 2 Bathrooms\n- Fully furnished kitchen\n- 24/7 water and security\n- Covered parking available\n- Pet friendly\n- 3rd floor with lift access\n- Nearby parks and gyms\n\nContact the owner for a visit or more details.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(houseTitle, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      houseImage,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.greenAccent,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.greenAccent,
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_sharp,
                          size: 25,
                          color: isFavorite ? Colors.pinkAccent : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            houseLocation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      housePrice,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Contact Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.phone, color: Colors.white),
                      label: Text(
                        ownerPhone,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Add call functionality here
                      },
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.message, color: Colors.white),
                      label: Text(
                        ownerMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Add message functionality here
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Short Description
              Text(houseShortDescription, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              const Text(
                "More Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                houseMoreInfo,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
