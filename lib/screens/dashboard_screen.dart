import 'package:flutter/material.dart';
import 'job_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Unified Schema Mock Data (representing scraped data)
  final List<Map<String, dynamic>> opportunities = [
    {
      "id": "1",
      "event_name": "Google Summer of Code 2026",
      "category": "Internship",
      "reward": "Stipend: \$1500 - \$3300",
      "deadline": DateTime.now().add(const Duration(days: 12)),
      "eligibility": "3rd/4th Year CSE",
      "source": "Unstop",
      "apply_link": "https://summerofcode.withgoogle.com/",
      "description": "Spend your summer writing code for an open source organization."
    },
    {
      "id": "2",
      "event_name": "Global AI Hackathon",
      "category": "Hackathon",
      "reward": "Prize: \$5000",
      "deadline": DateTime.now().add(const Duration(days: 3)),
      "eligibility": "Open to all",
      "source": "Devpost",
      "apply_link": "https://devpost.com/",
      "description": "Build the next generation of AI tools over a 48-hour sprint."
    },
    {
      "id": "3",
      "event_name": "Amazon SDE Intern",
      "category": "Internship",
      "reward": "Stipend: ₹80,000/mo",
      "deadline": DateTime.now().add(const Duration(days: 1)),
      "eligibility": "3rd Year CSE/IT",
      "source": "Internshala",
      "apply_link": "https://amazon.jobs/",
      "description": "Join AWS team as an SDE intern for 6 months."
    },
  ];

  String selectedFilter = "All";

  int _calculateDaysRemaining(DateTime deadline) {
    return deadline.difference(DateTime.now()).inDays;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = opportunities.where((opp) {
      if (selectedFilter == "All") return true;
      return opp["category"] == selectedFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Opportunity Feed", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {}, // Profile button
          )
        ],
      ),
      body: Column(
        children: [
          // 🔹 CATEGORY FILTERING (MVP Requirement)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: ["All", "Hackathon", "Internship", "Scholarship"].map((filter) {
                bool isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => selectedFilter = filter);
                    },
                    selectedColor: const Color(0xFF0D47A1),
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),

          // 🔹 FEED UI
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                var opp = filteredList[index];
                int daysLeft = _calculateDaysRemaining(opp["deadline"]);
                
                // Color code deadlines (Urgent = Red)
                Color deadlineColor = daysLeft <= 3 ? Colors.red : Colors.green;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      opp["event_name"],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.monetization_on, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(opp["reward"], style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.source, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text("Source: ${opp["source"]}", style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer, color: deadlineColor),
                        Text(
                          "$daysLeft Days left",
                          style: TextStyle(color: deadlineColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JobDetailScreen(opportunityData: opp)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}