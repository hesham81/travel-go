import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  _HotelHomeState createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  String _selectedTab = 'About';
  int _adults = 1;
  int _children = 0;
  int _rooms = 1;
  String _roomType = 'Single';
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  List<String> _selectedFacilities = [];

  final List<String> _facilities = [
    'Wi-Fi',
    'Pool',
    'Free Cancellation',
    'Breakfast Included',
    'Restaurant',
    'Public Parking',
    'Air Conditioning',
  ];

  double _calculateTotalPrice() {
    if (_checkInDate == null || _checkOutDate == null) return 0.0;
    int nights = _checkOutDate!.difference(_checkInDate!).inDays;
    if (nights <= 0) return 0.0;
    double basePrice = 100;
    double roomMultiplier = (_roomType == 'Single')
        ? 1
        : (_roomType == 'Double')
            ? 1.5
            : 2.0;
    double facilityCost = _selectedFacilities.length * 10.0;
    return nights * _rooms * basePrice * roomMultiplier + facilityCost;
  }

  void _resetAccommodation() {
    setState(() {
      _adults = 1;
      _children = 0;
      _rooms = 1;
      _roomType = 'Single';
      _checkInDate = null;
      _checkOutDate = null;
      _selectedFacilities.clear();
    });
  }

  void _goToReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservationScreen()),
    );
  }

  Future<void> _pickDate(bool isCheckIn) async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  Widget _buildTab(String label) {
    bool isSelected = _selectedTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = label;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.grey[600],
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                width: 40,
                height: 2,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }

  bool _isExpanded = false;
  final String fullText = '''
Facing the beachfront, Penguin Village Dahab offers 3-star accommodation in Dahab and features a garden, shared lounge and terrace. The accommodation provides a 24-hour front desk, airport transfers, room service and free WiFi throughout the property.
At the hotel you will find a restaurant serving African, Italian and Seafood cuisine. A vegan option can also be requested.
Bike hire and car hire are available at this hotel and the area is popular for cycling.
Dahab Beach is 1.2 km from Penguin Village Dahab. Sharm el-Sheikh International Airport is 93 km away.
Couples particularly like the location — they rated it 9.8 for a two-person trip.''';

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Share',
            style: TextStyle(color: AppColors.blackColor),
          ),
          content: Text(
            'Share this accommodation with your friends!',
            style: TextStyle(color: AppColors.blackColor),
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: AppColors.blackColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added to favorites!',
            style: TextStyle(color: AppColors.blackColor),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Hotel",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: _showShareDialog,
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: _toggleFavorite,
          ),
          // Map Icon Button
          IconButton(
            icon: const Icon(Icons.location_on, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://pix10.agoda.net/hotelImages/2307867/0/973661d1b15c479bb73fc1243bb774f2.jpg?s=1024x768',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Penguin Village Dahab',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Expanded(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '4.5 (365 reviews)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    '13 Mashraba Street, Dahab, Egypt',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTab('About'),
                      _buildTab('Accommodation'),
                      _buildTab('Review'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_selectedTab == 'About') _informationContent(),
                  if (_selectedTab == 'Accommodation') _accommodationContent(),
                  if (_selectedTab == 'Review') _reviewContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _isExpanded ? fullText : '${fullText.substring(0, 100)}...',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'See less' : 'See more',
              style: TextStyle(
                color: AppColors.newBlueColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Fast facts',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 32,
            runSpacing: 16,
            children: [
              _fastFactItem(Icons.access_time, 'Check in from', '13:30'),
              _fastFactItem(Icons.access_time, 'Check out by', '12:00'),
              _fastFactItem(Icons.coffee, 'Breakfast', 'Breakfast available.'),
              _fastFactItem(Icons.pets, 'Pets', 'Pets are not allowed.'),
              _fastFactItem(Icons.people, 'Children',
                  'Children are welcome at this hotel.'),
            ],
          ),
        ],
      );

  Widget _fastFactItem(IconData icon, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(description),
      ],
    );
  }

  Widget _accommodationContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Check-in & Check-out',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _dateSelector(
                  'Check-in Date', _checkInDate, () => _pickDate(true)),
              const SizedBox(width: 16),
              _dateSelector(
                  'Check-out Date', _checkOutDate, () => _pickDate(false)),
            ],
          ),
          const Divider(height: 32),
          const Text(
            'Guests',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          _counterRow(
              'Adults', _adults, (val) => setState(() => _adults = val)),
          _counterRow(
              'Children', _children, (val) => setState(() => _children = val)),
          const Divider(height: 32),
          const Text(
            'Rooms',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          _counterRow('Rooms', _rooms, (val) => setState(() => _rooms = val)),
          const SizedBox(height: 8),
          const Text(
            'Room Type',
            style: TextStyle(color: AppColors.blackColor),
          ),
          DropdownButton<String>(
            value: _roomType,
            items: ['Single', 'Double', 'Suite'].map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  type,
                  style: TextStyle(color: AppColors.blackColor),
                ),
              );
            }).toList(),
            onChanged: (val) => setState(() => _roomType = val!),
          ),
          const Divider(height: 32),
          const Text(
            'Facilities',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Wrap(
            spacing: 10,
            children: _facilities.map((facility) {
              final isSelected = _selectedFacilities.contains(facility);
              return ChoiceChip(
                label: Text(facility),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? _selectedFacilities.add(facility)
                        : _selectedFacilities.remove(facility);
                  });
                },
              );
            }).toList(),
          ),
          const Divider(height: 32),
          Text(
            'Total Price: \$${_calculateTotalPrice().toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _goToReservationScreen,
                  child: const Text('OK'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetAccommodation,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.blackColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _dateSelector(String label, DateTime? date, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                date != null
                    ? '${date.toLocal()}'.split(' ')[0]
                    : 'Select Date',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _counterRow(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.blackColor),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
            ),
            Text(
              value.toString(),
              style: TextStyle(color: AppColors.blackColor),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }

  bool _isLiked1 = false; // For the first review

  Widget _reviewContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Categories Section
          Wrap(
            spacing: 32,
            runSpacing: 16,
            children: [
              _categoryItem('Cleanliness', 4.1),
              _categoryItem('Location', 4.0),
              _categoryItem('Service', 4.1),
              _categoryItem('Facilities', 4.0),
            ],
          ),

          const SizedBox(height: 16),

          // Individual Reviews
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://source.unsplash.com/random/100x100?person=1'),
            ),
            title: const Text(
              'John Doe',
              style: TextStyle(color: AppColors.blackColor),
            ),
            subtitle: const Text(
              'Great place to stay! Highly recommended.',
              style: TextStyle(color: AppColors.blackColor),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  _isLiked1 = !_isLiked1;
                });
              },
            ),
          ),

          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://source.unsplash.com/random/100x100?person=2'),
            ),
            title: Text(
              'Jane Smith',
              style: TextStyle(color: AppColors.blackColor),
            ),
            subtitle: const Text(
              'The location is perfect, and the staff is friendly.',
              style: TextStyle(color: AppColors.blackColor),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  _isLiked1 = !_isLiked1;
                });
              },
            ),
          ),
        ],
      );

  // Helper method to create a category item with a progress bar
  Widget _categoryItem(String label, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(color: AppColors.blackColor),
            ),
            Text(
              rating.toString(),
              style: TextStyle(color: AppColors.blackColor),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: rating / 5,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ],
    );
  }
}

// Placeholder for Reservation Screen
class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text(
          'Reservation Screen',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Map',
          style: TextStyle(color: AppColors.blackColor),
        ),
      ),
      body: const Center(
        child: Text(
          'This is the map screen.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
