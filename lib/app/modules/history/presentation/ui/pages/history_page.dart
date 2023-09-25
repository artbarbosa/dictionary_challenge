import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../info/presentation/ui/pages/info_page.dart';
import '../controllers/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final controller = GetIt.I.get<HistoryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      controller.loadHistory();
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
        title: "History",
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
          controller.loadHistory();
        },
      ),
    );
  }
}
