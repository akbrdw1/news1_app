class OnBoardingModel {
  String title;
  String description;
  String image;

  OnBoardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoardingModel> contents = [
  OnBoardingModel(
    title: 'The best digital magazine.',
    description:
        'Start exploring the hottest news topics around the world with us anywhere.',
    image: 'assets/ob/ob1.png',
  ),
  OnBoardingModel(
    title: 'Stay up to date with selected news',
    description:
        'Get the latest news selected by editors according to your interests from all over the world.',
    image: 'assets/ob/ob2.png',
  ),
  OnBoardingModel(
    title: 'Enrich your understanding of the world.',
    description:
        'The latest and hottest news from around the world, making you understand more about your surroundings.',
    image: 'assets/ob/ob3.png',
  ),
];
