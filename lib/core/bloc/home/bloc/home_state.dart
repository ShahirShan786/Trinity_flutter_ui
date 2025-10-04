part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
    final bool isExpanded;
  const HomeState(this.isExpanded);
  
  @override
  List<Object> get props => [isExpanded];
}

final class HomeInitial extends HomeState {
  const HomeInitial() : super(false);

}

final class CategoryUpdated extends HomeState{
  const CategoryUpdated(super.isExpanded);
}
