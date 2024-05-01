import 'package:sate_social/features/home/data/models/partner_match_model.dart';
import 'package:sate_social/features/home/data/models/self_match_model.dart';
import 'package:sate_social/features/home/domain/repositories/match_repository.dart';

import '../../../../core/data/data_sources/firestore_data_source.dart';

class MatchRepositoryImpl implements MatchRepository {
  final FirestoreDataSource firestoreDataSource;

  const MatchRepositoryImpl({required this.firestoreDataSource});

  @override
  Future<void> addPartnerMatch({required String userId, required PartnerMatchModel partnerMatchModel}) async {
    await firestoreDataSource.addPartnerMatchForm(userId, partnerMatchModel);
  }

  @override
  Future<void> addSelfMatch({required String userId, required SelfMatchModel selfMatchModel}) async {
    await firestoreDataSource.addSelfMatchForm(userId, selfMatchModel);
  }
}