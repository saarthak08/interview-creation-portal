import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';

import 'package:interview_app/src/repository/network_config.dart';

class _FileRepository {
  Client _client = Client();

  Future<StreamedResponse> uploadResume(PlatformFile file, int id) async {
    var uri = Uri.parse("$baseURL/file/upload/$id");
    var request = MultipartRequest("POST", uri);
    request.headers["Content-Type"] = 'multipart/form-data';
    request.files.add(MultipartFile.fromBytes(
        'file', File(file.path!).readAsBytesSync(),
        filename: file.name));
    return request.send();
  }

  Future<Response> downloadResume(String url) async {
    return _client.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader:
            'application/json; application/octet-stream',
      },
    );
  }
}

_FileRepository? _fileRepository;

_FileRepository get fileRepository {
  if (_fileRepository == null) {
    _fileRepository = _FileRepository();
  }
  return _fileRepository!;
}
