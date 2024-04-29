import 'package:sate_social/features/home/data/models/partner_match_model.dart';

import '../repositories/match_repository.dart';

class PartnerMatchUseCase {
  final MatchRepository matchRepository;

  PartnerMatchUseCase({required this.matchRepository});

  Future<void> call(String userId, PartnerMatchModel partnerMatchModel) {
    return matchRepository.addPartnerMatch(
        userId: userId,
        partnerMatchModel: partnerMatchModel
    );
  }
}