import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';

part 'owner_home_page_state.dart';

class OwnerHomePageCubit extends Cubit<OwnerHomePageState> {
  OwnerHomePageCubit() : super(OwnerHomePageInitial());
}
