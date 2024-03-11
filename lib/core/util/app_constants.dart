import '../../features/community/data/models/post_model.dart';

class AppConstants {
  static const String appName = 'Sate Social';
  static const double appVersion = 1.0;

  static const List<String> genderList = ['Male', 'Female', 'Non Binary'];
  static const List<String> ethnicityList = ['American Indian', 'White', 'Black', 'Asian',
    'Hispanic/Latino', 'Pacific Islander', 'No Preference'
  ];

  static const List<String> sexualityList = ['Straight', 'Gay', 'Lesbian', 'Bisexual',
    'Allosexual', 'Androsexual', 'Asexual', 'Autosexual', 'Bicurious', 'Demisexual',
    'Fluid', 'Graysexual', 'Gynesexual', 'Monosexual', 'Omnisexual', 'Pansexual',
    'Polysexual', 'Queer', 'Questioning', 'Skoliosexual', 'Spectrasexual', 'Other type out'
  ];

  static const List<String> openToConnectToList = ['Romantically', 'Friends/ Activity Partners', 'Professionally'];

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