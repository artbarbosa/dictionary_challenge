import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../info/presentation/ui/pages/info_page.dart';
import '../controllers/favorite_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  final controller = GetIt.I.get<FavoriteController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.loadFavorites();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWordsComponent(
        words: List.generate(
          controller.words.length,
          (index) => controller.words[index].word,
        ),
        title: "Favorites",
        onTap: (String word) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoPage(
                      word,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                    )),
          );
          controller.loadFavorites();
        },
      ),
    );
  }
}
