class UnBoardingContent {
  String image;
  String title;
  String description;

  UnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<UnBoardingContent> contents = [
  UnBoardingContent(
    image: 'assets/screen1.png',
    title: 'Select From Our Best Menu',
    description:
        'Pick Your food from our menu\n\t\t\t\t\t\t\t\t  More than 35 times',
  ),

  UnBoardingContent(
    image: 'assets/screen2.png',
    title: 'Easy and Online Payment',
    description:
        'You Can Pay Cash on Delivary and\n\t\t\t\t\t\t\t\t Card Payment is available',
  ),

  UnBoardingContent(
    image: 'assets/screen3.png',
    title: 'Quick Delivary at Your \n\t\t\t\t\t\t\t\t\t\t\t  DoorStep',
    description: 'Deliver Your Food\n\t\t\t\t\t at DoorStep',
  ),
];
