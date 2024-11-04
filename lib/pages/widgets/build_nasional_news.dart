import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news1_app/constans/theme.dart';
import 'package:news1_app/models/news_nasional_model.dart';
import 'package:news1_app/pages/news_detail_page.dart';

class BuildNasionalNews extends StatelessWidget {
  final NewsNasionalModel news;
  const BuildNasionalNews({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: (news.posts ?? []).map((techno) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(link: techno.link ?? ''),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(techno.thumbnail ?? ''),
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          techno.title ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              (news.title?.split(" - ").last ?? ''),
                              style: lightGreyTextStyle.copyWith(
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: lightGreyColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              formatDate(techno.pubDate.toString()),
                              style: lightGreyTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('MMMM, dd', 'id_ID').format(dateTime);
  }
}
