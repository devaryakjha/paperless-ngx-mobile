import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'documents_state.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit() : super(DocumentsInitial());
}
