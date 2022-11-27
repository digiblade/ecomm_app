import 'package:ecommerce/Component2/Buttons/SolidButton.dart';
import 'package:ecommerce/Component2/Input/InputField.dart';
import 'package:ecommerce/Components/Appbar/app_bar.dart';
import 'package:ecommerce/Components/Card/address_card.dart';
import 'package:ecommerce/Models/AddressModel.dart';
import 'package:ecommerce/Models/DrawerPage.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:ecommerce/Util/Space.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController number = TextEditingController();
  List<AddressModel> addressList = [];
  bool isLoading = false;
  addAddressData() {
    AddressModel userData = AddressModel(
      username: fullname.text,
      address: address.text,
      contact: number.text,
      pincode: pincode.text,
    );
    addAddress(userData);
    fullname.clear();
    address.clear();
    number.clear();
    pincode.clear();
    Navigator.pop(context);
    getAddressData();
  }

  @override
  void initState() {
    super.initState();
    getAddressData();
  }

  getAddressData() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<AddressModel> addList = await getAddress();
      setState(() {
        addressList = addList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: secondary),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              builder: (BuildContext context) {
                return Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const VerticalSpace(
                            space: 4,
                          ),
                          const Text(
                            'Add your address',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const VerticalSpace(
                            space: 8,
                          ),
                          InputField(
                            label: "Full Name",
                            controller: fullname,
                          ),
                          InputField(
                            label: "Address",
                            controller: address,
                          ),
                          InputField(
                            label: "Pincode",
                            controller: pincode,
                            type: TextInputType.number,
                          ),
                          InputField(
                            label: "Contact Number",
                            type: TextInputType.phone,
                            controller: number,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: SolidButton(
                              onPressed: addAddressData,
                              color: primary,
                              label: "Add",
                            ),
                          ),
                          VerticalSpace(
                            space: MediaQuery.of(context).viewInsets.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        key: _scaffoldKey,
        drawer: const DrawerPage(),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    children: addressList
                        .map(
                          (AddressModel address) => AddressCard(
                            address: address,
                            onEditDone: getAddressData,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
