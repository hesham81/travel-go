import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/updateflight.dart';

class Browseflight extends StatelessWidget {
  const Browseflight({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> flightList = [
      "Flight Trip 1",
      "Flight Trip 2",
      "Flight Trip 3",
      "Flight Trip 4"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff0d75b4),
          ),
        ),
        title: Text(
          "Travel Go",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff0d75b4),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemCount: flightList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Updateflight(),
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
                            flightList[index],
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
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRW7BdKkJMK5F2VhXDNC5r6-SW0Sg-rxY571A&s',
                        width: 80,
                        height: 80,
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
    );
  }
}