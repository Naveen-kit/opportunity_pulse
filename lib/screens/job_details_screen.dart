import 'package:flutter/material.dart';

class JobDetailScreen extends StatelessWidget {
  final Map<String, dynamic> opportunityData;

  const JobDetailScreen({super.key, required this.opportunityData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0D47A1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                opportunityData["category"],
                style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            
            // Title
            Text(
              opportunityData["event_name"],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Info Boxes
            _buildInfoRow(Icons.monetization_on, "Reward", opportunityData["reward"]),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.school, "Eligibility", opportunityData["eligibility"]),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.public, "Scraped From", opportunityData["source"]),
            
            const Divider(height: 40, thickness: 1),
            
            const Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              opportunityData["description"],
              style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // In a real app, use url_launcher package to open opportunityData["apply_link"]
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Redirecting to ${opportunityData["source"]}...")),
              );
            },
            child: const Text("Apply Now", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0D47A1), size: 28),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}