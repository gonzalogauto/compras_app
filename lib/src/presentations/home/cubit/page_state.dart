part of 'page_cubit.dart';

class PageState {
  PageState({this.pageIndex = 0});
  final int pageIndex;

  PageState copyWith({
    int? pageIndex,
  }) {
    return PageState(
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
