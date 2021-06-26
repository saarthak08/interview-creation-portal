import 'package:http/http.dart';

import 'package:interview_app/src/repository/network_config.dart';

class _InterviewerRepository {
  Client _client = Client();

  Future<Response> getInterviewers() async {
    return await _client.get(
      Uri.parse('$baseURL/interviewer/all'),
    );
  }
}

_InterviewerRepository? _intervieweeRepository;

_InterviewerRepository get intervieweeRepository {
  if (_intervieweeRepository == null) {
    _intervieweeRepository = _InterviewerRepository();
  }
  return _intervieweeRepository!;
}
