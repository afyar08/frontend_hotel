import 'package:flutter/material.dart';

class ReservedStatus extends StatefulWidget {
  const ReservedStatus({Key? key}) : super(key: key);

  @override
  State<ReservedStatus> createState() => _ReservedStatusState();
}

class _ReservedStatusState extends State<ReservedStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchInput(), // Integrating the SearchInput widget here
          Expanded(
            child: Placeholder(), // Placeholder for other content
          ),
        ],
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () {
          setState(() {
            // Set _selectedDate to null when the search field is tapped
            // Clear _guests
            // Fill _guests with all initial guest data
          });
        },
        onChanged: (value) {
          setState(() {
            _searchText = value.toLowerCase();
            _isSearching = true; // Start searching
          });
        },
      ),
    );
  }
}