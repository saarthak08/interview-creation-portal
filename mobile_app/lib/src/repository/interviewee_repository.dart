import 'dart:io';

import 'package:http/http.dart';

import 'package:interview_app/src/repository/network_config.dart';

class _IntervieweeRepository {
  Client _client = Client();

  Future<Response> getInterviewees() async {
    return await _client.get(
      Uri.parse('$baseURL/interviewee/all'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
  }
}

_IntervieweeRepository? _intervieweeRepository;

_IntervieweeRepository get intervieweeRepository {
  if (_intervieweeRepository == null) {
    _intervieweeRepository = _IntervieweeRepository();
  }
  return _intervieweeRepository!;
}
