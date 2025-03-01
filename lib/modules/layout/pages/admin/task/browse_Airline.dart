import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'flightdepartureairline.dart';

class BrowseAirlines extends StatelessWidget {
  const BrowseAirlines({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> arabAirlines = [
      {
        "name": "Emirates",
        "logoUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Emirates_logo.svg/1934px-Emirates_logo.svg.png"
      },
      {
        "name": "Qatar Airways",
        "logoUrl": "https://static.cdnlogo.com/logos/q/78/qatar-airways-thumb.png"
      },
      {
        "name": "Etihad Airways",
        "logoUrl": "https://logos-world.net/wp-content/uploads/2023/01/Etihad-Airways-Logo.png"
      },
      {
        "name": "Saudia",
        "logoUrl": "https://logos-world.net/wp-content/uploads/2023/01/Saudi-Arabian-Airlines-Logo.png"
      },
      {
        "name": "EgyptAir",
        "logoUrl": "https://upload.wikimedia.org/wikipedia/commons/7/7d/Egypt_air_logo.jpg"
      },
      {
        "name": "Royal Jordanian",
        "logoUrl": "https://download.logo.wine/logo/Royal_Jordanian/Royal_Jordanian-Logo.wine.png"
      },
      {
        "name": "Kuwait Airways",
        "logoUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmUbMy-h1L2mYJr7Q9grMmMZypCpb3YsOlckpQH-bxoXxLFUOcx7F1eBPkSE_ClvJnmyc&usqp=CAU"
      },
      {
        "name": "Oman Air",
        "logoUrl": "https://download.logo.wine/logo/Oman_Air/Oman_Air-Logo.wine.png"
      },
      {
        "name": "Middle East Airlines (MEA)",
        "logoUrl": "https://download.logo.wine/logo/Middle_East_Airlines/Middle_East_Airlines-Logo.wine.png"
      },
      {
        "name": "Flydubai",
        "logoUrl": "https://1000logos.net/wp-content/uploads/2020/04/FlyDubai-Logo.jpg"
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Color(0xff0d75b4),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Tour And Travel ",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search, color: Color(0xff0d75b4)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff0d75b4),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xff0d75b4),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                itemCount: arabAirlines.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlightDepartureairline(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
              
                                  arabAirlines [index]["name"]!,
                                  style: TextStyle(
                                    fontFamily: "Poppins-SemiBold",
                                    color: Color(0xff0d75b4),
                                    fontSize: 21,
                                  ),
                                ),
                                SizedBox(height: 7),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              arabAirlines[index]["logoUrl"]!,
                              width: 150,
              
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}