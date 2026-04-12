import 'package:opporto_project/featuers/company_jobs/data/model/job_model.dart';
import 'package:opporto_project/featuers/company_jobs/domain/repo/jop_repo.dart';

class GetJobUseCase {
  JopRepo jopRepo;
  GetJobUseCase({required this.jopRepo});
  Future<List<JobModel>>  call(String token) async {
    try {
    return await jopRepo.getMyJobs(token);
    }catch(e){
      rethrow;
    }
  }
}