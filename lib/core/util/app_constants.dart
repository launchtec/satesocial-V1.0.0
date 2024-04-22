import 'package:sate_social/features/community/data/models/post_category.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import 'images.dart';

class AppConstants {
  static const String appName = 'Sate Social';
  static const double appVersion = 1.0;
  static const String termOfUseLink = 'https://satesocial.com/sate-social-terms-of-use/';

  // Sign Up constants
  static const List<String> genderList = ['Male', 'Female', 'Non Binary'];
  static const List<String> ageList = ['18', '19', '20', '21', '22', '23', '24', '25', '26',
    '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41',
    '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56',
    '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71',
    '72', '73', '74', '75', '76', '77', '77', '78', '79', '80', '81', '82', '83', '84', '85',
    '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '100'
  ];
  static const List<String> heightList = ['4 FT 11 IN', '5 FT 0 IN', '5 FT 1 IN', '5 FT 2 IN',
    '5 FT 3 IN', '5 FT 4 IN', '5 FT 5 IN', '5 FT 6 IN', '5 FT 7 IN', '5 FT 8 IN', '5 FT 10 IN',
    '5 FT 11 IN', '6 FT 0 IN', '6 FT 1 IN', '6 FT 2 IN', '6 FT 3 IN', '6 FT 4 IN', '6 FT 5 IN',
    '6 FT 6 IN', '6 FT 7 IN', '6 FT 8 IN', '6 FT 9 IN', '6 FT 10 IN'];
  static const List<String> ethnicityList = ['American Indian', 'White', 'Black', 'Asian',
    'Hispanic/Latino', 'Pacific Islander', 'No Preference'
  ];
  static const List<String> sexualityList = ['Straight', 'Gay', 'Lesbian', 'Bisexual',
    'Allosexual', 'Androsexual', 'Asexual', 'Autosexual', 'Bicurious', 'Demisexual',
    'Fluid', 'Graysexual', 'Gynesexual', 'Monosexual', 'Omnisexual', 'Pansexual',
    'Polysexual', 'Queer', 'Questioning', 'Skoliosexual', 'Spectrasexual', 'Other type out'
  ];
  static const List<String> openToConnectToList = ['Romantically', 'Friends/ Activity Partners',
    'Professionally'];

  // Community Post constants
  static const List<String> postCategories = ['Romance Posting', 'Social & Activity Posting',
    'Professional & Gig Economy'];
  static const List<String> romanceGroups = ['Couples', 'Group', 'Threeway', 'FF', 'MM', 'MF',
    'FFM', 'MMF', 'FFF+', 'MMM+', 'MFMF'];
  static const List<PostCategory> socialGroups = [
    PostCategory(name: 'Science &\nSpace', imagePath: Images.flaskIcon),
    PostCategory(name: 'Snowboard\nor Skiing', imagePath: Images.skiLiftIcon),
    PostCategory(name: 'Clubbing\nor Nightlife', imagePath: Images.dancingIcon),
    PostCategory(name: 'Cocktail', imagePath: Images.cocktailIcon),
    PostCategory(name: 'Coffee\nor Tea', imagePath: Images.coffeeCupIcon),
    PostCategory(name: 'Park', imagePath: Images.parkIcon),
    PostCategory(name: 'Mountain\nSports', imagePath: Images.mountainIcon),
    PostCategory(name: 'Museum\nor Art', imagePath: Images.galleryIcon),
    PostCategory(name: 'Comics\nor Anime', imagePath: Images.comicBookIcon),
    PostCategory(name: 'Smoking', imagePath: Images.marijuanaIcon),
    PostCategory(name: 'Restaurants', imagePath: Images.dinnerIcon),
    PostCategory(name: 'Gardening', imagePath: Images.gardeningIcon),
    PostCategory(name: 'Gaming', imagePath: Images.gameControllerIcon),
    PostCategory(name: 'Movie', imagePath: Images.videoPlayerIcon),
    PostCategory(name: 'Music', imagePath: Images.pianoIcon),
    PostCategory(name: 'Cooking\nor Baking', imagePath: Images.chefIcon),
    PostCategory(name: 'Carshare\nor Errands', imagePath: Images.carSharingIcon),
    PostCategory(name: 'Alumni', imagePath: Images.studentsIcon),
    PostCategory(name: 'Cycling', imagePath: Images.bicycleIcon),
    PostCategory(name: 'Book\nClub', imagePath: Images.agendaIcon),
    PostCategory(name: 'Board\n& Card Game', imagePath: Images.chessIcon),
    PostCategory(name: 'Animals', imagePath: Images.petCareIcon),
    PostCategory(name: 'All things\nDog', imagePath: Images.dogIcon),
    PostCategory(name: 'Mom\'s\nMeet-up', imagePath: Images.motherAndSonIcon),
    PostCategory(name: 'Recreational\nSports', imagePath: Images.ballsSportsIcon),
    PostCategory(name: 'Running\n& Walking', imagePath: Images.runnerIcon),
    PostCategory(name: 'Beer', imagePath: Images.beerIcon)
  ];
  static const List<String> gigIndustries = ['Aerospace', 'Agriculture', 'Automotive', 'Business', 'Construction', 'Education',
    'Energy', 'Entertainment', 'Fashion', 'Finance', 'Food industry', 'Food service', 'Forestry or Mountain services',
    'Health Science & Medical Technology', 'Healthcare', 'Industrial Electronics', 'Insurance', 'IT', 'Manufacturing',
    'Transportation', 'Other type'];
  static const List<String> employmentTypes = ["Full time", "Part time", "Contract", "Temporary", "Freelancer"];

  static List<NotificationModel> notificationModals = [
    NotificationModel(
        id: '1',
        title: 'Based on gig filters',
        content: 'New request to connect to your card',
        created: '5 mins ago',
        location: '5 miles away'
    ),
    NotificationModel(
        id: '2',
        title: 'Based on love filters',
        content: 'New request to connect to your card',
        created: '15 mins ago',
        location: '2 miles away'
    )
  ];
}