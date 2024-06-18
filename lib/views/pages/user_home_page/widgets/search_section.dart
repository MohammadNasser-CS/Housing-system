import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/user_home_page_cubit/user_home_cubit.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  // late final GlobalKey<FormState> _formKey;
  late final TextEditingController _searchController;

  String? onwerName, password;
  late FocusNode _searchFocusNode;
  bool visibility = false;
  @override
  void initState() {
    // _formKey = GlobalKey<FormState>();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: TextFormField(
            textAlign: TextAlign.right,
            controller: _searchController,
            focusNode: _searchFocusNode,
            onEditingComplete: () async {
              _searchFocusNode.unfocus();
              if (_searchController.text.isNotEmpty) {
                await cubit.searchFilled(_searchController.text);
              } else {
                await cubit.getHomeData();
              }
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (value) async {
              // debugPrint(value);
              if (value.isNotEmpty) {
                await cubit.searchFilled(value);
              } else {
                await cubit.getHomeData();
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "الرجاء إدخال الإسم الكامل";
              } else if (!RegExp(r'^[ء-ي\s]+$').hasMatch(value)) {
                return "الرجاء إدخال إسم صحيح يحتوي على الأحرف العربية فقط";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.all(size.width * 0.03),
              hintText: 'رقم العقار...',
              prefixIcon: const Icon(Icons.search_outlined),
              prefixIconColor: AppColor.grey,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {},
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsetsDirectional.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: AppColor.orange8,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                FontAwesomeIcons.sliders,
                color: AppColor.white,
                size: size.width * 0.05,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
