import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Roommates"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.search, size: 24),
                const SizedBox(width: 16),
                Icon(Icons.filter_alt_outlined, size: 24),
              ],
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location section
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 20, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  "Indiranagar, Bengaluru",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),

          // List of roommates
          Expanded(
            child: ListView(
              children: [
                _buildRoommateCard(
                  profile:
                      "images/google.jpg", // Replace with your actual image path
                  name: "Payal Patel",
                  time: "30min ago",
                  price: "3000",
                  description:
                      "2BHK available near paras Town Hall\nLorem Ipsum is simply dummy text of the printing and typesetting industry.",
                ),
                Divider(height: 1, color: Colors.grey[300]),
                _buildRoommateCard(
                  profile:
                      "images/google.jpg", // Replace with your actual image path
                  name: "Rahul Rana",
                  time: "30min ago",
                  price: "3500",
                  description:
                      "2BHK available near paras Town Hall\nLorem Ipsum is simply dummy text of the printing and typesetting industry.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoommateCard({
    required String profile,
    required String name,
    required String time,
    required String price,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile picture
          CircleAvatar(radius: 24, backgroundImage: AssetImage(profile)),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Price
                Text(
                  "₹$price",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 12),

                // Message and checkboxes
                Row(
                  children: [
                    Text(
                      "Message",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.check_box_outline_blank,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.check_box_outline_blank,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
