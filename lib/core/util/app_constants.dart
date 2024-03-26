import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../../features/community/data/models/post_model.dart';

class AppConstants {
  static const String appName = 'Sate Social';
  static const double appVersion = 1.0;

  // Sign Up constants
  static const List<String> genderList = ['Male', 'Female', 'Non Binary'];
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
  static const List<String> socialGroups = ['Science & Space', 'Snowboard or Skiing', 'Clubbing or Nightlife',
    'Cocktail', 'Coffee or Tea', 'Park', 'Mountain Sports', 'Museum or Art', 'Comics or Anime', 'Smoking', 'Restaurants',
    'Gardening', 'Gaming', 'Movie', 'Music', 'Cooking or Baking', 'Carshare or Errands', 'Alumni', 'Cycling',
    'Book Club', 'Board & Card Game', 'Animals', 'All things Dog', 'Mom\'s Meet-up', 'Recreational Sports', 'Running & Walking',
    'Beer'];
  static const List<String> gigIndustries = ['Aerospace', 'Agriculture', 'Automotive', 'Business', 'Construction', 'Education',
    'Energy', 'Entertainment', 'Fashion', 'Finance', 'Food industry', 'Food service', 'Forestry or Mountain services',
    'Health Science & Medical Technology', 'Healthcare', 'Industrial Electronics', 'Insurance', 'IT', 'Manufacturing',
    'Transportation', 'Other type'];

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