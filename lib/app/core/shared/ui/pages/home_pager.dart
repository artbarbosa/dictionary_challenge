import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../../modules/favorites/presentation/ui/pages/favorite_page.dart';
import '../../../../modules/history/presentation/ui/pages/history_page.dart';
import '../../../../modules/list/pressentation/ui/pages/word_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomTabView(
          tabs: [
            CustomTabData(
              label: 'Word List',
              child: WordListPage(),
            ),
            CustomTabData(
              label: 'History',
              child: HistoryPage(),
            ),
            CustomTabData(
              label: 'Favorites',
              child: FavoritePage(),
            ),
          ],
        ),
      ),
    );
  }
}
