import 'package:opporto_project/featuers/company_jobs/data/model/InterviewResponseModel.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class GetInterviewUesCase {
  final JopRepo jopRepo;

  GetInterviewUesCase({required this.jopRepo});

  Future<List<InterviewData>> call(String token) async {
    try {
      final res = await jopRepo.getMyInterviews(token);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}