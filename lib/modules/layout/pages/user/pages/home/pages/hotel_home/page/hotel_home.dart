import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_container.dart';

import '../../../../../../../../../core/providers/collections_provider.dart';

class HotelDetailsScreen extends StatelessWidget {
  final String name;
  final String info;
  final String image;

  const HotelDetailsScreen({
    super.key,
    required this.name,
    required this.info,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              info,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'This hotel offers amazing services, luxury rooms, and excellent locations for your vacation or business travel.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  final List<Map<String, String>> hotels = [
    {
      'name': 'Luxury Palace Hotel',
      'info': 'Paris, 5 stars',
      'image':
          'https://villagrouploreto.s3.amazonaws.com/uploads/photo/image/4682/villa-del-palmar-beach-resort-and-spa-at-the-islands-of-loreto.jpg'
    },
    {
      'name': 'Mountain View Inn',
      'info': 'Colorado, 4 stars',
      'image':
          'https://cf.bstatic.com/xdata/images/hotel/max1024x768/428664130.jpg?k=4f1621d7f40460e9e18d76a7d39d3b80012b76c06f186426d93eae845f5e1eb8&o=&hp=1',
    },
    {
      'name': 'Beachfront Resort',
      'info': 'Maldives, 5 stars',
      'image':
          'https://thumbs.dreamstime.com/b/huts-swimming-pool-luxury-hotel-saadiyat-island-abu-dhabi-uae-29850750.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CollectionsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            0.01.height.hSpace,
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return CustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            hotel['image']!,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel['name']!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hotel['info']!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HotelDetailsScreen(
                                        name: hotel['name']!,
                                        info: hotel['info']!,
                                        image: hotel['image']!,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: AppColors.newBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    0.01.height.hSpace,
              ),
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
