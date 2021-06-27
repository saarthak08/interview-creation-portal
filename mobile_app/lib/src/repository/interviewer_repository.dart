import 'dart:io';

import 'package:http/http.dart';

import 'package:interview_app/src/repository/network_config.dart';

class _InterviewerRepository {
  Client _client = Client();

  Future<Response> getInterviewers() async {
    return await _client.get(
      Uri.parse('$baseURL/interviewer/all'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
  }
}

_InterviewerRepository? _intervieweeRepository;

_InterviewerRepository get interviewerRepository {
  if (_intervieweeRepository == null) {
    _intervieweeRepository = _InterviewerRepository();
  }
  return _intervieweeRepository!;
}
