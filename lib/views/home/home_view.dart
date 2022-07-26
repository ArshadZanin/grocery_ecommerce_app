import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop_grocery_app/core/locator.dart';
import 'package:shop_grocery_app/views/cart/cart_view.dart';
import 'package:shop_grocery_app/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(
        httpService: locator(),
      ),
      onModelReady: (viewModel) async {
        await viewModel.initialize();
      },
      builder: (context, viewModel, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 243, 236, 236),
              title: const Text(
                'Grocery',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    viewModel.selectedData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartView(
                          datas: viewModel.selectedData,
                        ),
                      ),
                    );
                    viewModel.notifyListeners();
                  },
                  child: const Icon(
                    Icons.keyboard_option_key,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 236, 236),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: MasonryGridView.builder(
                      itemCount: viewModel.data.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            List<int?> listOfId = viewModel.selectedData
                                .map((e) => e.id)
                                .toList();
                            if (!listOfId.contains(viewModel.data[index].id)) {
                              viewModel.selectedData.add(viewModel.data[index]);
                            }
                            viewModel.notifyListeners();
                          },
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Image.network(
                                        '${viewModel.data[index].image}'),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '\$${viewModel.data[index].price}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${viewModel.data[index].title}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${viewModel.data[index].rating!.count} items',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                viewModel.selectedData.isNotEmpty
                    ? SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              viewModel.selectedData = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartView(
                                    datas: viewModel.selectedData,
                                  ),
                                ),
                              );
                              viewModel.notifyListeners();
                            },
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: viewModel.selectedData.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            '${viewModel.selectedData[index].image}',
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  child: Text(
                                    '${viewModel.selectedData.length}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Offstage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
