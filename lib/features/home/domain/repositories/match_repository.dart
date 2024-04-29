import 'package:sate_social/features/home/data/models/partner_match_model.dart';
import 'package:sate_social/features/home/data/models/self_match_model.dart';

abstract class MatchRepository {
  Future<void> addSelfMatch({
    required String userId,
    required SelfMatchModel selfMatchModel
  });

  Future<void> addPartnerMatch({
    required String userId,
    required PartnerMatchModel partnerMatchModel
  });
}