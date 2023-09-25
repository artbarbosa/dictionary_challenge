import 'package:collection/collection.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/info_controller.dart';
import '../states/info_states.dart';

class InfoPage extends StatefulWidget {
  final String word;
  final Function() onPressed;

  const InfoPage(this.word, {super.key, required this.onPressed});

  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  final controller = GetIt.I.get<InfoController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.getWord(widget.word);
      await controller.getPreviousAndNextWord(widget.word);
      controller.getFavoriteBox(widget.word);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.stopTTS();
    super.dispose();
  }

  Widget generateRow(String key, List<String> meanings) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: AppTextStyles.medium14px.copyWith(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                ...meanings.mapIndexed(
                  (index, text) => Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('${index + 1} - ${text.capitalize()}',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 15,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [];

    if (controller.wordModel != null) {
      for (String key in controller.wordModel!.definitions.keys) {
        listWidget.add(
            generateRow(key, controller.wordModel!.definitions[key] ?? []));
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: widget.onPressed,
        ),
      ),
      body: ValueListenableBuilder<InfoStates>(
          valueListenable: controller,
          builder: (context, value, child) {
            if (value is InfoStatesSuccessState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Builder(
                        builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.word,
                                              style: AppTextStyles.semiBold32px
                                                  .copyWith(
                                                      color: AppColors.primary),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.volume_up,
                                                  color: AppColors.black,
                                                ),
                                                onPressed: () {
                                                  controller.speak(widget.word);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "/${controller.wordModel!.pronunciation}/",
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  color: AppColors.black,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                alignment: Alignment.topCenter,
                                                isSelected:
                                                    controller.isFavorite,
                                                icon: const Icon(
                                                  Icons.favorite_outline,
                                                ),
                                                selectedIcon: const Icon(
                                                  Icons.favorite,
                                                  color: AppColors.red,
                                                  size: 32,
                                                ),
                                                onPressed: () {
                                                  controller.isFavorite =
                                                      !controller.isFavorite;
                                                  controller.setFavorite(
                                                      widget.word,
                                                      controller.isFavorite);
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: listWidget,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (controller.orderWord?.previous != null &&
                                  controller.orderWord!.previous.isNotEmpty)
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InfoPage(
                                            controller.orderWord!.previous,
                                            onPressed: () {
                                              Navigator.pop(context);

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Anterior"),
                                  ),
                                ),
                              const SizedBox(width: 10),
                              if (controller.orderWord?.next != null &&
                                  controller.orderWord!.next.isNotEmpty)
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InfoPage(
                                              controller.orderWord!.next,
                                              onPressed: () {
                                            Navigator.pop(context);
                                            setState(() {});
                                          }),
                                        ),
                                      );
                                    },
                                    child: const Text("Próximo"),
                                  ),
                                )
                            ]),
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
