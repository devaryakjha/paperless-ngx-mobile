import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paperless/exports.dart';

part 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit() : super(const DocumentsState());

  DocumentsService get _documentsService => getIt<DocumentsService>();

  Future<void> getAll() async {
    emit(state.copyWith(fetchState: FetchState.loading));
    final response = await _documentsService.getAll();
    if (response.isSuccessful) {
      emit(
        state.copyWith(
          document: response.body!.results,
          fetchState: FetchState.success,
        ),
      );
    }
  }
}
