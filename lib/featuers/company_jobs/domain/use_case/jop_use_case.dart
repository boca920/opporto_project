import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class JopUseCase {
  JopRepo jopRepo;
  JopUseCase({required this.jopRepo});
  Future<void> call(JobModel jobData, String userToken) async {
    try {

      return await jopRepo.postNewJob(jobData, userToken);
    } catch (e) {

      rethrow;
    }
  }
}