import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lala_awinty/admin_app/edi_meal_ui.dart';
import 'package:lala_awinty/constants/controllers.dart';
import 'package:lala_awinty/models/meal.dart';
import 'package:lala_awinty/widgets/loading_widget.dart';

class ListMeals extends StatefulWidget {
  const ListMeals({Key? key}) : super(key: key);

  @override
  State<ListMeals> createState() => _ListMealsState();
}

class _ListMealsState extends State<ListMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('List des repas'),),
      body: FutureBuilder<List<MealModel>>(
        future: mealController.getListOfMeals(),
        builder: (context,AsyncSnapshot<List<MealModel>> snapshot){
          if(snapshot.hasError){
            return const Center(
              child: Text('No internet'),
            );
          }
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text("vous avez pas ajouté des recommendatioms"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemBuilder:(context,int index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data![index].photoURL.toString()
                      ),
                    ),
                    title: Text(snapshot.data![index].title.toString()),
                    subtitle: Text(snapshot.data![index].mealType.toString()),
                    trailing: SizedBox(
                      width: Get.width * .45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${snapshot.data![index].priceRange.toString()} DH'),
                          SizedBox(width: Get.width *.02,),
                          // GestureDetector(
                          //   child:const Icon(Icons.edit),
                          // ),
                          GestureDetector(
                            child:const Icon(Icons.delete),
                            onTap: (){
                              Get.defaultDialog(
                               radius: 5,
                                contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                                title: 'Attention',
                                content: Text('êtes sûr de vouloir supprimer cet repas'),
                                actions: <Widget>[
                                  TextButton(
                                      //onPressed:()async=>print(snapshot.data![index].id),
                                      onPressed:()async=>await  mealController.deleteMeal(snapshot.data![index].id).then((_) {
                                        Get.back();
                                        setState(() {

                                        });
                                      }
                                      ),
                                      child:const Text('Oui')
                                  ),
                                  TextButton(
                                      onPressed: ()=>Get.back(),
                                      child:const Text('Annuler')
                                  ),
                                ]
                              );
                            },
                          ),  GestureDetector(
                            child:const Icon(Icons.edit),
                            onTap: () async{
                             //show edit form for clicked meal :
                              await Get.bottomSheet(
                                 SizedBox(
                                    child: EditMealUI(idMeal: snapshot.data![index].id!,),
                                    height: Get.height * .9,
                                ),
                                isScrollControlled: true
                              ).then((value) {
                                setState(() {

                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    horizontalTitleGap: 10,
                  );
                },
              itemCount: snapshot.data!.length,
            );
          }
          return Center(
            child: LoadingWidget(),
          );
        },
      ),
    );
  }
}
