import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/models/attractions_model.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/selected_attraction.dart';
import '/modules/layout/pages/admin/pages/attractions/widget/explore_attractions.dart';

class UpdateAttraction extends StatefulWidget {
  const UpdateAttraction({super.key});

  @override
  State<UpdateAttraction> createState() => _UpdateAttractionState();
}

class _UpdateAttractionState extends State<UpdateAttraction> {
  List<AttractionsModel> attractions = [
    AttractionsModel(
      title: "Eiffel Tower",
      location: "Paris, France",
      description:
          "The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France.",
      imageUrl: "https://source.unsplash.com/1600x900/?eiffel,tower",
      videoUrl: "https://www.youtube.com/watch?v=rlWO9QIgX8I",
    ),
    AttractionsModel(
      title: "Times Square",
      location: "New York City, USA",
      description:
          "Times Square is a major commercial intersection, tourist destination, and entertainment hub in Midtown Manhattan.",
      imageUrl: "https://source.unsplash.com/1600x900/?times,square",
      videoUrl: "https://www.youtube.com/watch?v=O7WbVj5apxU",
    ),
    AttractionsModel(
      title: "Colosseum",
      location: "Rome, Italy",
      description:
          "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy.",
      imageUrl: "https://source.unsplash.com/1600x900/?colosseum,rome",
      videoUrl: "https://www.youtube.com/watch?v=oo1WZ4nqET4",
    ),
    AttractionsModel(
      title: "Shibuya Crossing",
      location: "Tokyo, Japan",
      description:
          "Shibuya Crossing is a popular shopping and entertainment area known for its iconic pedestrian scramble.",
      imageUrl: "https://source.unsplash.com/1600x900/?shibuya,crossing",
      videoUrl: "https://www.youtube.com/watch?v=QkG4JSHW1kA",
    ),
    AttractionsModel(
      title: "Sydney Opera House",
      location: "Sydney, Australia",
      description:
          "The Sydney Opera House is a multi-venue performing arts centre at Sydney Harbour.",
      imageUrl: "https://source.unsplash.com/1600x900/?sydney,opera",
      videoUrl: "https://www.youtube.com/watch?v=6mBO2vqLv38",
    ),
    AttractionsModel(
      title: "Big Ben",
      location: "London, UK",
      description:
          "Big Ben is the nickname for the Great Bell of the clock at the north end of the Palace of Westminster.",
      imageUrl: "https://source.unsplash.com/1600x900/?big,ben",
      videoUrl: "https://www.youtube.com/watch?v=t1nFvfs2fqo",
    ),
    AttractionsModel(
      title: "Burj Khalifa",
      location: "Dubai, UAE",
      description:
          "Burj Khalifa is the tallest building in the world, standing at 828 meters.",
      imageUrl: "https://source.unsplash.com/1600x900/?burj,khalifa",
      videoUrl: "https://www.youtube.com/watch?v=2aB2Q4lG7yI",
    ),
    AttractionsModel(
      title: "Sagrada Familia",
      location: "Barcelona, Spain",
      description:
          "Sagrada Familia is a large unfinished Roman Catholic church designed by architect Antoni Gaudí.",
      imageUrl: "https://source.unsplash.com/1600x900/?sagrada,familia",
      videoUrl: "https://www.youtube.com/watch?v=1F2hV1vxI8k",
    ),
    AttractionsModel(
      title: "Christ the Redeemer",
      location: "Rio de Janeiro, Brazil",
      description:
          "Christ the Redeemer is an Art Deco statue of Jesus Christ in Rio de Janeiro, Brazil.",
      imageUrl: "https://source.unsplash.com/1600x900/?christ,redeemer",
      videoUrl: "https://www.youtube.com/watch?v=Qj7eWaR6u2k",
    ),
    AttractionsModel(
      title: "Machu Picchu",
      location: "Machu Picchu, Peru",
      description:
          "Machu Picchu is a 15th-century Inca citadel located in the Eastern Cordillera of southern Peru.",
      imageUrl: "https://source.unsplash.com/1600x900/?machu,picchu",
      videoUrl: "https://www.youtube.com/watch?v=6H8A2xXjx4E",
    ),
    AttractionsModel(
      title: "Grand Canyon",
      location: "Grand Canyon, USA",
      description:
          "The Grand Canyon is a steep-sided canyon carved by the Colorado River in Arizona.",
      imageUrl: "https://source.unsplash.com/1600x900/?grand,canyon",
      videoUrl: "https://www.youtube.com/watch?v=6H8A2xXjx4E",
    ),
    AttractionsModel(
      title: "Venice Canals",
      location: "Venice, Italy",
      description:
          "Venice is famous for its canals, gondolas, and historic architecture.",
      imageUrl: "https://source.unsplash.com/1600x900/?venice,italy",
      videoUrl: "https://www.youtube.com/watch?v=JphHw6iU4m8",
    ),
    AttractionsModel(
      title: "Fushimi Inari Shrine",
      location: "Kyoto, Japan",
      description:
          "Fushimi Inari Shrine is famous for its thousands of vermilion torii gates.",
      imageUrl: "https://source.unsplash.com/1600x900/?fushimi,inari",
      videoUrl: "https://www.youtube.com/watch?v=5kZ4w5z9Jz4",
    ),
    AttractionsModel(
      title: "Great Pyramid of Giza",
      location: "Cairo, Egypt",
      description:
          "The Great Pyramid of Giza is the oldest and largest of the three pyramids in the Giza pyramid complex.",
      imageUrl: "https://source.unsplash.com/1600x900/?pyramid,giza",
      videoUrl: "https://www.youtube.com/watch?v=4S8Z1i7xL8k",
    ),
    AttractionsModel(
      title: "Grand Palace",
      location: "Bangkok, Thailand",
      description:
          "The Grand Palace is a complex of buildings at the heart of Bangkok, Thailand.",
      imageUrl: "https://source.unsplash.com/1600x900/?grand,palace",
      videoUrl: "https://www.youtube.com/watch?v=2Z5P5v5z5Z4",
    ),
    AttractionsModel(
      title: "Van Gogh Museum",
      location: "Amsterdam, Netherlands",
      description:
          "The Van Gogh Museum houses the largest collection of artworks by Vincent van Gogh.",
      imageUrl: "https://source.unsplash.com/1600x900/?van,gogh",
      videoUrl: "https://www.youtube.com/watch?v=3Z5Z5Z5Z5Z4",
    ),
    AttractionsModel(
      title: "Prague Castle",
      location: "Prague, Czech Republic",
      description:
          "Prague Castle is a castle complex in Prague, dating back to the 9th century.",
      imageUrl: "https://source.unsplash.com/1600x900/?prague,castle",
      videoUrl: "https://www.youtube.com/watch?v=4Z5Z5Z5Z5Z4",
    ),
    AttractionsModel(
      title: "Hagia Sophia",
      location: "Istanbul, Turkey",
      description:
          "Hagia Sophia is a historic mosque and former cathedral in Istanbul.",
      imageUrl: "https://source.unsplash.com/1600x900/?hagia,sophia",
      videoUrl: "https://www.youtube.com/watch?v=5Z5Z5Z5Z5Z4",
    ),
    AttractionsModel(
      title: "Golden Gate Bridge",
      location: "San Francisco, USA",
      description:
          "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate Strait.",
      imageUrl: "https://source.unsplash.com/1600x900/?golden,gate",
      videoUrl: "https://www.youtube.com/watch?v=6Z5Z5Z5Z5Z4",
    ),
    AttractionsModel(
      title: "Great Wall of China",
      location: "Beijing, China",
      description:
          "The Great Wall of China is a series of fortifications made of stone, brick, and other materials.",
      imageUrl: "https://source.unsplash.com/1600x900/?great,wall",
      videoUrl: "https://www.youtube.com/watch?v=7Z5Z5Z5Z5Z4",
    ),
    // Add more attractions here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Go"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  SelectedAttraction.routeName,
                  arguments: attractions[index],
                ),
                child: ExploreAttractions(
                  model: attractions[index],
                ),
              ),
              separatorBuilder: (context, index) => 0.01.height.hSpace,
              itemCount: attractions.length,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
