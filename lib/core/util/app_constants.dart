import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../../features/community/data/models/post_model.dart';

class AppConstants {
  static const String appName = 'Sate Social';
  static const double appVersion = 1.0;

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

  static const List<String> openToConnectToList = ['Romantically', 'Friends/ Activity Partners', 'Professionally'];

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

  static const List<PostModel> postModals = [
    PostModel(
        id: '1',
        title: 'Im a handyman looking for work',
        content: '',
        category: '',
        group: '',
        zip: '',
        created: '1 min ago',
        location: '15 mi'),
    PostModel(
        id: '2',
        title: 'Need plumber ASAP',
        content: '',
        category: '',
        group: '',
        zip: '',
        created: '5 min ago',
        location: '12 mi'),
    PostModel(
        id: '3',
        title: 'Math and science tutors needed',
        content: '',
        category: '',
        group: '',
        zip: '',
        created: '10 min ago',
        location: '1 mi'),
    PostModel(
        id: '4',
        title: 'Trying to find a reliable dog walker',
        content: '',
        category: '',
        group: '',
        zip: '',
        created: '12 min ago',
        location: '20 mi'),
    PostModel(
        id: '5',
        title: 'In need of a tutor',
        content: '',
        category: '',
        group: '',
        zip: '',
        created: '23 min ago',
        location: '3 mi'),
    PostModel(
        id: '6',
        title: 'Hiring! Tutor for Kindergarten',
        content: '',
        category: '',
        group: '',
        zip: '',
        created: '27 min ago',
        location: '8 mi')
  ];
}