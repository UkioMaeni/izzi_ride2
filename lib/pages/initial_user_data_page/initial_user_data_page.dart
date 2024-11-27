import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/pages/initial_user_data_page/components/input_names.dart';

class InitialUserDataPage extends StatefulWidget {
  const InitialUserDataPage({super.key});

  @override
  State<InitialUserDataPage> createState() => _InitialUserDataPageState();
}

class _InitialUserDataPageState extends State<InitialUserDataPage> {

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _surnameController=TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _surnameFocusNode = FocusNode();


  @override
  void initState() {
    _nameController.addListener((){
      setState(() {
        errorName="";
      });
    });
    _surnameController.addListener((){
      setState(() {
        errorSurname="";
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _nameFocusNode.dispose();
    _surnameFocusNode.dispose();
    super.dispose();
  }



  String errorName="";
  String errorSurname="";

  bool isValidData(){
    if(_nameController.text.isEmpty){
      setState(() {
        errorName="Please enter your name";
      });
    }
    if(_surnameController.text.isEmpty){
      setState(() {
        errorSurname="Please enter your last name";
      });
    }
    if(errorName.isEmpty || errorSurname.isEmpty){
      return true;
      
    }else{
      return false;
    }
  }

  Future<void> setNamesUser()async{
    if(!isValidData()) return;
    final result= await UserHttp.I.setInitUserData(_nameController.text, _surnameController.text);
    if(result is CustomResponse<bool>){
      goToMainMenu();
    }else{

    }
  }

  goToMainMenu(){
    context.goNamed(RoutesName.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          NavBar(
            onBack: () {
              
            },
          ),
          SizedBox(height: 54,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(),
                  Text(
                    "Enter your name",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    "Share real name for safer rides.",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 16,
                      color: BrandColor.grey167,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 32,),
                  InputNames(
                    hint: "First Name",
                    focusNode: _nameFocusNode,
                    textEditingController: _nameController,
                    isError: errorName.isNotEmpty,
                  ),
                  if(errorName.isNotEmpty)Text(
                    errorName,
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.red,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 16,),
                  InputNames(
                    hint: "Last Name",
                    focusNode: _surnameFocusNode,
                    textEditingController: _surnameController,
                    isError: errorSurname.isNotEmpty,
                  ),
                  if(errorSurname.isNotEmpty)Text(
                    errorSurname,
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.red,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 32,),
                  UIButton(
                    label: "Next",
                    onFuture: setNamesUser,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}