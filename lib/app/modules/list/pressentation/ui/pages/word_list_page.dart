import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../info/presentation/ui/pages/info_page.dart';
import '../controllers/word_list_controller.dart';
import '../states/word_list_states.dart';

class WordListPage extends StatefulWidget {
  const WordListPage({super.key});

  @override
  WordListPageState createState() => WordListPageState();
}

class WordListPageState extends State<WordListPage> {
  final controller = GetIt.I.get<WordListController>();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.getAndVerifyInitalData();

    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        controller.getMoreData();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<WordListState>(
        valueListenable: controller,
        builder: (context, value, child) {
          if (value is WordListSuccessState) {
            return SingleChildScrollView(
              controller: controller.scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Word List",
                      style: AppTextStyles.bold28px
                          .copyWith(color: AppColors.black),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.7,
                      ),
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        if (index < controller.items.length) {
                          return FutureBuilder(
                              future: controller.getFavoriteBox(
                                  controller.items[index].current),
                              builder: (context, snapshot) {
                                final isFavorite = snapshot.data ?? false;
                                return GridTile(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InfoPage(
                                              controller.items[index].current,
                                              onPressed: () {
                                            Navigator.pop(context);
                                            setState(() {});
                                          }),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(4),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.items[index].current,
                                            style: AppTextStyles.medium14px
                                                .copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const SizedBox(height: 1),
                                          SizedBox(
                                            height: 10,
                                            child: IconButton(
                                              padding: const EdgeInsets.all(0),
                                              isSelected: isFavorite,
                                              icon: const Icon(
                                                Icons.favorite_outline,
                                                size: 20,
                                              ),
                                              selectedIcon: const Icon(
                                                Icons.favorite,
                                                color: AppColors.red,
                                                size: 20,
                                              ),
                                              onPressed: () async {
                                                await controller.setFavorite(
                                                  controller
                                                      .items[index].current,
                                                  !isFavorite,
                                                );
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        return null;
                      },
                    ),
                    if (controller.isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
