import 'package:sate_social/features/home/data/models/self_match_model.dart';
import 'package:sate_social/features/home/domain/repositories/match_repository.dart';

class SelfMatchUseCase {
  final MatchRepository matchRepository;

  SelfMatchUseCase({required this.matchRepository});

  Future<void> call(String userId, SelfMatchModel selfMatchModel) {
    return matchRepository.addSelfMatch(
        userId: userId,
        selfMatchModel: selfMatchModel
    );
  }
}