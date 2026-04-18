import 'package:opporto_project/featuers/company_jobs/presentation/manager/bloc/job_state.dart';

class ApplicationState {
  final RequestStatus status;
  final String? message;
  final String? errorMessage;

  ApplicationState({
    this.status = RequestStatus.init,
    this.message,
    this.errorMessage,
  });

  ApplicationState copyWith({
    RequestStatus? status,
    String? message,
    String? errorMessage,
  }) {
    return ApplicationState(
      status: status ?? this.status,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}