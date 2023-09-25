import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ListWordsComponent extends StatelessWidget {
  final String? title;
  final List<String> words;
  final Function(String word) onTap;

  const ListWordsComponent({
    required this.words,
    super.key,
    this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "",
              style: AppTextStyles.bold28px.copyWith(color: AppColors.black),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: words.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTap(words[index]);
                  },
                  child: SizedBox(
                    height: 48.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            words[index],
                            style: AppTextStyles.medium14px.copyWith(
                              color: AppColors.primary,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
