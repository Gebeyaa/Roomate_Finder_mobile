import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _currentPriceValue = 3000;
  int _selectedBedrooms = 1;

  final List<String> _subCities = [
    'Galele',
    'Addis Ketema',
    'Yeka',
    'Gulele',
    'Bole',
    'Kirkos',
  ];

  final Map<String, bool> _selectedSubCities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF0A6FBA),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white54, width: 1),
          ),
          child: const Center(
            child: Text(
              'Filter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A6FBA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter based on your preference',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              'Price Range',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('3000 ETB'), Text('5000 ETB')],
            ),
            Slider(
              value: _currentPriceValue,
              min: 3000,
              max: 5000,
              divisions: 4,
              onChanged: (value) {
                setState(() {
                  _currentPriceValue = value;
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            const Text(
              'Bed room',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  [1, 2, 3, 4].map((number) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBedrooms = number;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              _selectedBedrooms == number
                                  ? Colors.blue
                                  : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            number.toString(),
                            style: TextStyle(
                              color:
                                  _selectedBedrooms == number
                                      ? Colors.white
                                      : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Sub City',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See All',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _subCities.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final subcity = _subCities[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            subcity,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Checkbox(
                        value: _selectedSubCities[subcity] ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedSubCities[subcity] = value ?? false;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ],
                  );
                },
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _currentPriceValue = 3000;
                        _selectedBedrooms = 1;
                        _selectedSubCities.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Gather selected subcities
                      final selectedSubCities =
                          _selectedSubCities.entries
                              .where((e) => e.value)
                              .map((e) => e.key)
                              .toList();
                      // Prepare filter data
                      final filterData = {
                        'price': _currentPriceValue,
                        'bedrooms': _selectedBedrooms,
                        'subCities': selectedSubCities,
                      };
                      Navigator.pop(context, filterData);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Apply filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
