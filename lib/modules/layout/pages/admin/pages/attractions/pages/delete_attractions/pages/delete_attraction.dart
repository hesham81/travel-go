import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/models/attractions_model.dart';
import '../../../widget/explore_attractions.dart';
import 'delete_selected_attraction.dart';

class DeleteAttraction extends StatefulWidget {
  const DeleteAttraction({super.key});

  @override
  State<DeleteAttraction> createState() => _DeleteAttractionState();
}

class _DeleteAttractionState extends State<DeleteAttraction> {
  List<AttractionsModel> attractions = [
    AttractionsModel(
        location: "Eiffel Tower, Paris",
        description:
        "A wrought-iron lattice tower in Paris, France, and one of the most recognizable landmarks in the world.",
        imageUrl:
        "https://i.pinimg.com/474x/be/08/d9/be08d9d7b0d57f9102f8d6ec3f9e2a0e.jpg"),
    AttractionsModel(
      location: "Grand Canyon, USA",
      description:
      "A breathtaking natural wonder known for its immense size and stunning landscapes.",
      imageUrl:
      "https://i.pinimg.com/474x/03/2f/7f/032f7f3c30ba1ff7a0a300b80149baac.jpg",
    ),
    AttractionsModel(
      location: "Great Wall of China",
      description:
      "An ancient series of walls and fortifications stretching across northern China.",
      imageUrl:
      "https://i.pinimg.com/474x/9d/c1/75/9dc175435728d5154f7cb77384a17c48.jpg",
    ),
    AttractionsModel(
      location: "Machu Picchu, Peru",
      description:
      "A 15th-century Inca citadel set high in the Andes Mountains.",
      imageUrl:
      "https://i.pinimg.com/474x/44/e6/3f/44e63fd319fe4ca864502c5819b45a6e.jpg",
    ),
    AttractionsModel(
      location: "Santorini, Greece",
      description:
      "A stunning Greek island known for its whitewashed buildings and blue domes.",
      imageUrl:
      "https://i.pinimg.com/474x/ef/75/1e/ef751e5a5d81a77e9e12dd93dc66f888.jpg",
    ),
    AttractionsModel(
      location: "Colosseum, Rome",
      description:
      "An ancient amphitheater in Rome, once used for gladiator contests and public spectacles.",
      imageUrl:
      "https://i.pinimg.com/474x/34/a8/b9/34a8b96ee490128a9e249bf70ca17227.jpg",
    ),
    AttractionsModel(
      location: "Taj Mahal, India",
      description:
      "A white marble mausoleum built by Emperor Shah Jahan in memory of his wife.",
      imageUrl:
      "https://i.pinimg.com/736x/d0/db/bb/d0dbbb3f2b35b89f385496ef82078544.jpg",
    ),
    AttractionsModel(
      location: "Pyramids of Giza, Egypt",
      description:
      "Iconic pyramids that have stood for over 4,500 years in the desert.",
      imageUrl:
      "https://i.pinimg.com/474x/e7/32/cf/e732cf6e211fc111d51d8156ec4d85e1.jpg",
    ),
    AttractionsModel(
      location: "Sydney Opera House, Australia",
      description:
      "A world-famous performing arts center with a unique sail-like design.",
      imageUrl:
      "https://i.pinimg.com/474x/7d/b0/97/7db097ceda199971ad4f1a1e1bd78bff.jpg",
    ),
    AttractionsModel(
      location: "Statue of Liberty, USA",
      description:
      "A symbol of freedom and democracy located in New York Harbor.",
      imageUrl:
      "https://i.pinimg.com/474x/92/7b/34/927b34755e3bdeb570ede29e6e708121.jpg",
    ),
    AttractionsModel(
      location: "Neuschwanstein Castle, Germany",
      description: "A fairy-tale castle nestled in the Bavarian Alps.",
      imageUrl:
      "https://i.pinimg.com/474x/53/3d/34/533d340615a38181947eacce72b8b6d2.jpg",
    ),
    AttractionsModel(
      location: "Dubai Burj Khalifa",
      description: "The tallest building in the world, standing at 828 meters.",
      imageUrl:
      "https://i.pinimg.com/474x/3f/63/2f/3f632f265c55fd526d94a1d65a54a74b.jpg",
    ),
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
                  DeleteSelectedAttraction.routeName,
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
