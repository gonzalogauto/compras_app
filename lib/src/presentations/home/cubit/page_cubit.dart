import 'package:bloc/bloc.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState());

  void updatePage(int newIndex) {
    emit(state.copyWith(pageIndex: newIndex));
  }
}
