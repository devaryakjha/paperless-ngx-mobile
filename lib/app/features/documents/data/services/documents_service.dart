import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:paperless/exports.dart' show Document, PaginatedResult;

part 'documents_service.chopper.g.dart';

@singleton
@ChopperApi(baseUrl: '/documents/')
abstract class DocumentsService extends ChopperService {
  @factoryMethod
  static DocumentsService create(ChopperClient? client) =>
      _$DocumentsService(client);

  @FactoryConverter(response: _convertRes)
  @Get()
  Future<Response<PaginatedResult<Document>>> getAll();
}

Response<PaginatedResult<Document>> _convertRes(Response<dynamic> res) {
  final json = jsonDecode(res.bodyString) as Map<String, dynamic>;
  final result = PaginatedResult.fromJson(
    json,
    (json) => Document.fromJson(json! as Map<String, dynamic>),
  );
  return res.copyWith(body: result);
}
