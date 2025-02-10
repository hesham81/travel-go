import 'package:flutter/material.dart';





class DahabTripScreen extends StatelessWidget {
  const DahabTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Dahab',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'Travel go',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Blue_Hole_2005.JPG/800px-Blue_Hole_2005.JPG'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dahab is a small Egyptian town on the southeast coast of the Sinai Peninsula in Egypt, approximately 80 km (50 mi) northeast of Sharm el-Sheikh.\n\n'
                          'Dahab can be divided into three major parts. Masbat, which includes the Bedouin village of Asalah, is in the north. South of Masbat is Mashraba, which is more touristic and has considerably more hotels. In the southwest is Medina, which includes the Laguna area, famous for its excellent shallow-water kite- and windsurfing.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trip Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    buildDetailRow('Destination:', 'Dahab'),
                    buildDetailRow('Price:', '5000 LE'),
                    buildDetailRow('Currency:', 'Egyptian'),
                    buildDetailRow('Number of Days:', '3 Days'),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Trip Departure', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    buildDetailRow('Start Date:', '10/10/2025'),
                    buildDetailRow('End Date:', '12/10/2025'),
                  ],
                ),
              ),
            ),
            buildProgramLineSection('20', 'Day 1', 'Blue Hole', 'Dahab', ['Scuba Diving']),
            buildProgramLineSection('21', 'Day 2', 'Laguna Beach', 'Dahab', ['Swimming', 'Relaxing', 'Kitesurfing']),
            buildProgramLineSection('22', 'Day 3', 'Three Pools', 'Dahab', ['Snorkeling', 'Diving']),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    // Add your reserve action here
                  },
                  child: Text('Reserve', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    // Add your next action here
                  },
                  child: Text('Next', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProgramLineSection(String id, String day, String location, String attractionLocation, List<String> activities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Program Line', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                buildDetailRow('ID:', id),
                buildDetailRow('Day:', day),
                buildDetailRow('Location:', location),
              ],
            ),
          ),
        ),
        buildAttractionSection(id, attractionLocation, activities),
      ],
    );
  }

  Widget buildAttractionSection(String attractionId, String location, List<String> activities) {
    String attractionName = '';
    if (attractionId == '20') {
      attractionName = 'Blue Hole';
    } else if (attractionId == '21') {
      attractionName = 'Laguna Beach';
    } else if (attractionId == '22') {
      attractionName = 'Three Pools';
    }

    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attraction Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text('ID: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(attractionId),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text('Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(attractionName),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text('Location: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(location),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text('Activity: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(activities.join(', ')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var activity in activities)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          Text(activity, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Image.network(
                            _getActivityImageUrl(activity),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getActivityImageUrl(String activity) {
    switch (activity) {
      case 'Scuba Diving':
        return 'https://pyramidsdivingcenter.com/wp-content/uploads/Downloader.la-644a89761e5f7.jpg';
      case 'Snorkeling':
        return'https://i0.wp.com/www.shamanduradiving.com/wp-content/uploads/2021/05/63.jpg?fit=600,401&ssl=1';
      case 'Kitesurfing':
        return'https://www.harry-nass.com/wp-content/uploads/2018/11/harr-nass-dahab-10.jpg';
      case 'Swimming':
        return'https://www.rottnestswimrun.com/wp-content/uploads/man-swimming-in-the-sea-2022-06-15-14-55-23-utc.jpg';
      case 'Relaxing':
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdiKHRkmxnV9f_if8vYwICDV1OVOrxcT7BRg&s';
      case 'Diving':
        return'https://pyramidsdivingcenter.com/wp-content/uploads/Downloader.la-644a89761e5f7.jpg';
      default:
        return 'https://example.com/default.jpg';
    }
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
