import 'package:sate_social/features/community/data/models/post_category.dart';

import 'images.dart';

class AppConstants {
  static const String appName = 'Sate Social';
  static const double appVersion = 1.0;
  static const String termOfUseLink = 'https://satesocial.com/sate-social-terms-of-use/';
  static const String privacyPolicyLink = 'https://satesocial.com/sate-social-privacy-policy/';
  static const String gigProductId = 'gig_post';
  static const String matchProductId = 'match_form';

  // Sign Up constants
  static const List<String> genderList = ['Male', 'Female', 'Non Binary'];
  static const List<String> listHello = ['Send a hello 👋', 'Send a flirt 😉', 'Send an introduction'];
  static const List<String> relationships = ['Single', 'In Relationship', 'It\'s Complicated'];
  static const List<String> ageList = ['18', '19', '20', '21', '22', '23', '24', '25', '26',
    '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41',
    '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56',
    '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71',
    '72', '73', '74', '75', '76', '77', '77', '78', '79', '80', '81', '82', '83', '84', '85',
    '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '100'];
  static const List<String> heightList = ['4 FT 11 IN', '5 FT 0 IN', '5 FT 1 IN', '5 FT 2 IN',
    '5 FT 3 IN', '5 FT 4 IN', '5 FT 5 IN', '5 FT 6 IN', '5 FT 7 IN', '5 FT 8 IN', '5 FT 10 IN',
    '5 FT 11 IN', '6 FT 0 IN', '6 FT 1 IN', '6 FT 2 IN', '6 FT 3 IN', '6 FT 4 IN', '6 FT 5 IN',
    '6 FT 6 IN', '6 FT 7 IN', '6 FT 8 IN', '6 FT 9 IN', '6 FT 10 IN'];
  static const List<String> ethnicityList = ['American Indian', 'White', 'Black', 'Asian',
    'Hispanic/Latino', 'Pacific Islander'];
  static const List<String> sexualityList = ['Straight', 'Gay', 'Lesbian', 'Bisexual',
    'Allosexual', 'Androsexual', 'Asexual', 'Autosexual', 'Bicurious', 'Demisexual',
    'Fluid', 'Graysexual', 'Gynesexual', 'Monosexual', 'Omnisexual', 'Pansexual',
    'Polysexual', 'Queer', 'Questioning', 'Skoliosexual', 'Spectrasexual'];
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
    PostCategory(name: 'Beer', imagePath: Images.beerIcon)];
  static const List<String> gigIndustries = ['Aerospace', 'Agriculture', 'Automotive', 'Business', 'Construction', 'Education',
    'Energy', 'Entertainment', 'Fashion', 'Finance', 'Food industry', 'Food service', 'Forestry or Mountain services',
    'Health Science & Medical Technology', 'Healthcare', 'Industrial Electronics', 'Insurance', 'IT', 'Manufacturing',
    'Transportation', 'Other type'];
  static const List<String> employmentTypes = ["Full time", "Part time", "Contract", "Temporary", "Freelancer"];

  // Match form - User Input for Self
  static const List<String> zodiacs = ['Aquarius', 'Aries', 'Cancer', 'Capricorn', 'Gemini', 'Leo', 'Libra', 'Pisces',
    'Sagittarius', 'Scorpio', 'Taurus', 'Virgo', 'Prefer not to say'];
  static const List<String> religions = ['Christian', 'Muslim', 'Hindi', 'Spiritual', 'Agnostic', 'Atheist', 'Jewish', 'Buddhist',
    'Other'];
  static const List<String> educations = ['High School', 'BS/BA', 'MBA/JD', 'Ph.D./MD'];
  static const List<String> children = ['I do not have children', 'I have children', 'Prefer not to say'];
  static const List<String> familyPlanning = ['I want children of my own', 'I am open to dating those with children',
    'I would be interesting in co- parenting', 'I do not want children', 'Prefer not to say'];
  static const List<String> marijuana = ['I smoke daily', 'Social smoker', 'Smoke free life', 'Prefer not to say'];
  static const List<String> cigarette = ['I smoke', 'Social smoker', 'Smoke free life', 'Prefer not to say'];
  static const List<String> alcohol = ['Heavy drinker', 'Moderate drinker', 'Social drinker', 'Alcohol free life', 'Prefer not to say'];
  static const List<String> diet = ['No preference/All foods', 'Pescatarian', 'Vegetarian', 'Vegan', 'Gluten free',
    'Dairy free'];
  static const List<String> politics = ['Liberal', 'Moderate', 'Conservative', 'Not political'];
  static const List<String> satisfactions = ['I am very happy and content with myself: always looking to flourish',
    'I am happy and content with myself, but have some self insecurities', 'I am happy and on the path to personal growth',
    'I am not satisfied with myself but making changes', 'I am not too satisfied with myself', 'Prefer not to say'];
  static const List<String> featuresBody = ['Back', 'Belly', 'Butt', 'Chest', 'Complexion', 'Eyes', 'Feet', 'Hair',
    'Hands', 'Height', 'Hips', 'Jawline', 'Legs', 'Lips', 'Muscles', 'Neck line', 'Shoulders', 'Smile', 'Teeth', 'Voice',
    'Prefer not to say'];
  static const List<String> thoughtsCheating = ['ENM', 'Cheating is never ok', 'I have cheated in my past relationships',
    'It\'s important to try to be faithful and communicate, but hookups happen',
    'Being true to your heart is more important than physical fidelity', 'Prefer not to say'];
  static const List<String> happiest = ['With Family and Friends', 'With my pet(s)', 'City lights energy', 'Near or on water',
    'Partaking in social events; bars, clubbing and meet ups', 'Watching and playing sports', 'Home body',
    'Healthy mix of homebody and social seeker'];
  static const List<String> workout = ['Daily', 'A few times a week', 'Several times a month', 'Not very often', 'Prefer not to say'];
  static const List<String> bodyType = ['Athletic', 'Average', 'Curvy', 'A few extra pounds', 'Slim', 'Overweight'];
  static const List<String> preferDress = ['Casually', 'Sporty', 'Practically', 'Elegantly', 'Fashionably', 'Appropriate to the occasion',
    'Uniquely and unconventionally'];
  static const List<String> importantSex = ['Very important', 'Important', 'Not particularly important', 'Not important', 'Prefer not to say'];
  static const List<String> marriage = ['I believe in marriage with the right partner', 'I do not believe in the institution of marriage',
    'Indifferent', 'Prefer not to say'];
  static const List<String> freeTime = ['Reading/ Mind enhancement activities', 'Watching movies and shows', 'Relaxation', 'Playing sports',
    'Working out', 'Going out to bars and restaurants', 'Pursuing my hobbies', 'Playing board games', 'Surfing the internet', 'Volunteering',
    'Hanging out with friends', 'Spending time with my family', 'Going to the theater/ arts/ museum', 'Listening to music', 'Mountains and nature',
    'Concerts', 'Exploring new areas', 'Trying new things'];
  static const List<String> eatingBehaviors = ['I\'m always cooking and trying new recipes', 'I like to cook occasionally', 'I only cook if I have to',
    'I only cook on special occasions', 'I only eat out', 'I only eat out on special occasions'];
  static const List<String> reasonsRelationship = ['Life is easier with a partner', 'Emotional security', 'To build a relationship of trust',
    'Frequent intimacy', 'I want someone to spend my free time with', 'So I\'m not alone', 'Security'];
  static const List<String> datingIntentions = ['Open relationship', 'Life partner', 'Long-term relationship', 'Open to short-term or long-term',
    'Short-term relationship', 'Trying to figure it out', 'Casual'];
  static const List<String> relationshipType = ['Monogamy', 'ENM', 'Married', 'Casual', 'Dates', 'FWB', 'Fun', 'Open relationship'];
  static const List<String> sportsHobbies = ['Tennis', 'Table tennis', 'Badminton', 'Soccer', 'Hockey', 'Handball', 'Volleyball', 'Basketball',
    'Swimming', 'Sailing', 'Rowing', 'Surfing', 'Cycling', 'Equestrian', 'Skiing', 'Jogging', 'Hiking', 'Rock climbing', 'Bowling',
    'Yoga/Pilates', 'Fitness', 'Track & field', 'Rollerblading', 'Golf', 'Cricket', 'Rugby', 'Fishing', 'Martial Arts', 'Motorsports',
    'Dancing', 'Diving', 'Baseball', 'Mountain Biking', 'Kayaking', 'Shooting', 'Football', 'Dancing', 'Theater', 'Photography', 'Film/Video',
    'Literature'];
  static const List<String> musicHobbies = ['Musicals', 'Opera Orchestral music', 'Chamber music', 'Folk music', 'Easy listening', 'Spiritual',
    'World music', 'Jazz', 'Rock', 'Metal/Hard Rock', 'Reggae', 'Rap', 'Dance', 'House', 'Blues', 'Hip Hop', 'Pop', 'Alternative', 'Country',
    'Electro', 'Gospel', 'Latin', 'R&B', 'Chillout', 'Funk/Soul', 'Classical music'];
  static const List<String> interestsHobbies = ['All things Art', 'Airsoft', 'Amateur radio', 'American football', 'Aquarium keeping', 'Archery',
    'Association football', 'Audiophilia', 'Auto racing', 'Badminton', 'Baking', 'Baseball', 'Basketball', 'Bonsai', 'Bowling', 'Climbing',
    'Computer programming', 'Cooking', 'Creative writing', 'Cricket', 'Cycling', 'Dance', 'Dancing', 'Disc golf', 'Diving', 'Drawing', 'Equestrian',
    'Equestrianism', 'Figure skating', 'Film/Video', 'Fishing', 'Fitness', 'Footbag', 'Football', 'Gardening', 'Genealogy', 'Golf', 'Golfing',
    'Graphic Designing', 'Gymnastics', 'Handball', 'Hiking', 'Hockey', 'Home automation', 'Ice hockey', 'Jewelry making', 'Jogging', 'Kart racing',
    'Kayaking', 'Knapping', 'Knitting', 'Lapidary', 'Literature', 'Locksport', 'Martial Arts', 'Motorsports', 'Mountain Biking', 'Mountaineering',
    'Musical instruments', 'Netball', 'Paintball', 'Painting', 'Photography', 'Planking', 'Racquetball', 'Rock climbing', 'Rollerblading', 'Rowing',
    'Rugby', 'Rugby league football', 'Running', 'Sailing', 'Scrapbooking', 'Sculpting', 'Sewing', 'Shooting', 'Singing', 'Skiing', 'Snowboarding',
    'Soccer', 'Squash', 'Surfing', 'Swimming', 'Table tennis', 'Tennis', 'Theater', 'Track & field', 'Volleyball', 'Watching movies',
    'Watching television', 'Woodworking', 'Yoga/Pilates'];
  static const List<String> fetishes = ['Age play', 'Auralism', 'Autoplushophilia', 'BDSM', 'Breath play', 'Breeding kink', 'Consensual nonconsent',
    'Cuckolding', 'Degradation kink', 'Dirty Talk', 'Exhibitionism', 'Female-led relationships', 'Financial domination', 'Foot fetish', 'Gags',
    'Group sex', 'Hosiery', 'Humiliation', 'Impact play', 'Katoptronophilia', 'Mummification', 'Nipple play', 'Orgasm control', 'Praise kink',
    'Roleplay', 'Ropes and Bondage', 'Sadism and Masochism', 'Sex parties', 'Trichophilia', 'Urophilia', 'Voyeurism', 'Wax play'
  ];


  // Match Input Fields
  static const List<String> vacations = ['Beach vacation', 'Sports / Activity holiday', 'Educational tour', 'Meditation', 'Cruises',
    'Resorts', 'Staycations', 'City trips', 'Vacations for pure relaxation', 'In the mountains', 'Camping', 'Adventure vacation',
    'Hiking', 'Spa vacation', 'Group travel'];
  static const List<String> personInterested = ['Profession', 'Financial means', 'Staying healthy and active', 'Kindness and good energies',
    'Attraction', 'Lifestyle', 'Worldly and knowledgeable'];

  static const String aboutUsText = 'Connectedness is key. At Sate Social we aim to seamlessly connect people in their communities. '
      'We are a social platform that promotes in- person socialization and in the moment connections. Our platform allows users to '
      'flourish personally and professionally while building a social network.  Single, partnered or somewhere in- between, '
      'our platform serves and welcomes all. No more wishing you said hello to the person you found special in Connect. '
      'Easily find friends looking to do what you love to do and what inspires you in Community. By interacting on our '
      'platform you help teach our tech who is truly compatible for you in Match. We built Sate Social to give users a platform to connect.';

  // Questions and answers
  static const List<String> questionsList = [
    'How Do I Setup My Profile?',
    'Is facial verification saved?',
    'How do I message and interact in Connect?',
    'What do the connection types in Connect mean?',
    'How Do I Post in Community? And how does it work?',
    'How Does Match Work?',
    'How do I use Sate Social? What’s the point?'
  ];
  static const List<String> answersList = [
    'After signing up, navigate to the "Connect" section to start setting up your public card/profile. Here, you can create a custom avatar, update your profile, and even link your Instagram account.',
    'Great question! No, it is not. We use this feature solely to verify that real humans are signing up for our platform. Once verification is complete, no data or images are saved.',
    'Connect is an interactive feature that lets you engage with nearby users who have been active within the last 15 minutes. By clicking on their icon/avatar on the map and selecting an ice breaker, you can initiate a direct message with them (provided they respond to your ice breaker). You can find these direct messages in the "Connect" screen under "Messages."',
    'In Connect, you can customize your card/profile settings to reflect one or a combination of the following options:\n- Open to Connecting Romantically\n- Open to Connecting with Friends\n- Open to Connecting Professionally\n\nThis lets others know around you what you are open / not open to connecting to.',
    'Go to the "Community" section and tap the "Post" button with the plus icon. The first option you\'ll see is "Category." The Community section offers three categories:\n- Romance Postings (Free to Post)\n- Social & Activity Postings (Free to Post)\n- Professional & Gig Economy Posts (\$4.99 per post, for both job seekers and employers)\n\nAll posts are visible to your local community and zip code. Professional & Gig Economy posts are featured prominently in their respective zip codes/areas.',
    'Match is a premium matchmaking service available for \$2.99 per round of match making. To use this service, tap "Match" on the home screen or the bottom bar of the app. Complete the "Self Match Intake Questions" and "Partner Preferences Questions," pay the \$2.99 fee, and wait for a member of our team to contact you. We will then match you with your top local matches on our app!',
    'Welcome to Sate Social, your in the moment people and community connect. We have designed Sate Social with our users privacy and safety as top priority. In order to eliminate bots and fake accounts, users will be prompted to verify their humanness by following prompts such as smiling, winking, nodding, etc. Once liveness is detected users will create their profile by way of customizing an avatar that is representative of self. Once created, users will have access to the platform and their local community in more ways than one.'
  ];


}