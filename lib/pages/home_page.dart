import 'package:flutter/material.dart';
import 'package:news1_app/models/news_update_model.dart';
import 'package:news1_app/pages/news_detail_page.dart';
import 'package:news1_app/pages/widgets/build_ekonomi_news.dart';
import 'package:news1_app/pages/widgets/build_tech_news.dart';
import 'package:news1_app/pages/widgets/build_nasional_news.dart';
import 'package:news1_app/providers/news_update_provider.dart';
import 'package:news1_app/providers/news_ekonomi_update_provider.dart';
import 'package:news1_app/providers/news_nasional_update_provider.dart';
import 'package:news1_app/providers/news_tekno_update_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController updateNewsScrollController = ScrollController();
  int updateNewsActiveIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<NewsUpdateProvider>(context, listen: false)
            .fetchNewsUpdate();
        Provider.of<NewsTeknoUpdateProvider>(context, listen: false)
            .fetchNewsTekno();
        Provider.of<NewsEkonomiUpdateProvider>(context, listen: false)
            .fetchNewsEkonomi();
        Provider.of<NewsNasionalUpdateProvider>(context, listen: false)
            .fetchNewsNasional();
      },
    );
    updateNewsScrollController.addListener(
      () {
        setState(() {
          updateNewsActiveIndex = (updateNewsScrollController.offset /
                  (MediaQuery.of(context).size.width / 1.6))
              .round();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 15),
          children: [
            buildProfile(),
            const SizedBox(
              height: 25,
            ),
            Consumer<NewsUpdateProvider>(
              builder: (context, newsUpdate, child) {
                if (newsUpdate.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (newsUpdate.newsList.isEmpty) {
                  return const Text("No news available");
                } else {
                  return buildNewsUpdate(newsUpdate.newsList.first);
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            buildNewsCategory(),
          ],
        ),
      ),
    );
  }

  Widget buildProfile() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
          ),
          const SizedBox(
            width: 8,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Siang',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Text(
                'Akbar Dwi Hertanto',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xfff39e3a),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/ic/noti.png',
                    width: 20,
                  ),
                  Positioned(
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Color(0xff08066ff),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildNewsUpdate(NewsUpdateModel news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terbaru',
        ),
        const SizedBox(
          height: 16,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: updateNewsScrollController,
          child: Row(
            children: (news.posts?.take(5) ?? []).map(
              (item) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(
                          link: news.link ?? '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.only(right: 23),
                    height: 206,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4)),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(item.thumbnail ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(news.image ?? ''),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              news.title?.split("|").first ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          item.title ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        buildDotIndicator(
            news.posts?.take(5).toList().length ?? 0, updateNewsActiveIndex),
      ],
    );
  }

  Widget buildDotIndicator(int count, int activeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) {
          double size = (index == activeIndex) ? 12 : 8;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: (index == activeIndex)
                  ? Color(0xfff39e3a)
                  : const Color(0xffd9d9d9),
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }

  Widget buildNewsCategory() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 30,
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.amber,
            ),
            indicatorColor: Colors.amber,
            dividerHeight: 0,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Tekno'),
              Tab(text: 'Ekonomi'),
              Tab(text: 'Nasional'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: TabBarView(
            controller: _tabController,
            children: [
              Consumer<NewsTeknoUpdateProvider>(
                builder: (context, techNews, child) {
                  if (techNews.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (techNews.teknoList.isEmpty) {
                    return const Text('No Data');
                  } else {
                    return BuildTechNews(news: techNews.teknoList.first);
                  }
                },
              ),
              Consumer<NewsEkonomiUpdateProvider>(
                builder: (context, ekonomiNews, child) {
                  if (ekonomiNews.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (ekonomiNews.ekonomiList.isEmpty) {
                    return const Text('No Data');
                  } else {
                    return BuildEkonomiNews(
                        news: ekonomiNews.ekonomiList.first);
                  }
                },
              ),
              Consumer<NewsNasionalUpdateProvider>(
                builder: (context, nasionalNews, child) {
                  if (nasionalNews.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (nasionalNews.nasionalList.isEmpty) {
                    return const Text('No Data');
                  } else {
                    return BuildNasionalNews(
                        news: nasionalNews.nasionalList.first);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
