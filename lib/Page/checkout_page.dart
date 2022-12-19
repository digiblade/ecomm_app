import 'package:ecommerce/Component2/Buttons/solid_button.dart';
import 'package:ecommerce/Components/Card/address_card.dart';
import 'package:ecommerce/Components/Card/cart_card.dart';
import 'package:ecommerce/Components/Card/total_card.dart';
import 'package:ecommerce/Models/address_model.dart';
import 'package:ecommerce/Models/cart_model.dart';
import 'package:ecommerce/Models/drawer_page.dart';
import 'package:ecommerce/Models/order_model.dart';
// import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:ecommerce/Util/space.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int activeState = 1;
  List stepList = [1, 2, 3];
  List<AddressModel> addressList = [];
  List<CartModel> cartItems = [];
  AddressModel? selectedAddress;
  @override
  void initState() {
    super.initState();
    getAddressData();
    getProductFromCart();
  }

  getAddressData() async {
    try {
      List<AddressModel> addList = await getAddress();
      setState(() {
        addressList = addList;
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  getProductFromCart() async {
    List<CartModel> cart = await getCartByAPI();
    setState(() {
      cartItems = cart;
    });
  }

  selectAddress(value) {
    List<AddressModel> addressFilteredList = addressList
        .where((AddressModel address) => address.addressUid == value)
        .toList();
    if (addressFilteredList.isNotEmpty) {
      setState(() {
        selectedAddress = addressFilteredList[0];
      });
    }
  }

  renderSteps() {
    return stepList.map((e) {
      return CircleAvatar(
        backgroundColor: e < activeState ? secondary : gray,
        child: Text(
          "$e",
          style: TextStyle(
            color: e < activeState ? Colors.white : secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }

  nextPage() {
    setState(() {
      if (activeState <= stepList.length) activeState += 1;
    });
  }

  backPage() {
    setState(() {
      if (activeState > 1) {
        activeState -= 1;
      }
    });
  }

  placeOrderData() async {
    AddressModel addressDetails = selectedAddress != null
        ? selectedAddress!
        : addressList.isNotEmpty
            ? addressList[0]
            : AddressModel();
    OrderModel orderData = OrderModel(
      address:
          "${addressDetails.username}, ${addressDetails.address}, ${addressDetails.pincode}, ${addressDetails.contact}",
      cartProduct: cartItems,
    );

    dynamic res = await placeOrder(orderData);
    if (res['response']) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/responsesuccesspage");
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/responsefailurepage");
    }
  }

  renderPage() {
    switch (activeState) {
      case 1:
        return AddressSelectionPage(
          activeState: activeState,
          onNextStep: nextPage,
          addressList: addressList,
          onAddressSelect: selectAddress,
          addressId: selectedAddress != null
              ? selectedAddress!.addressUid
              : addressList.isNotEmpty
                  ? addressList[0].addressUid
                  : "",
        );
      case 2:
        return PaymentModeSelectionPage(
          activeState: activeState,
          onNextStep: nextPage,
          onBackStep: backPage,
        );
      case 3:
        return FinalOrderPage(
          activeState: activeState,
          onNextStep: placeOrderData,
          onBackStep: backPage,
          productList: cartItems,
          selectedAddress: selectedAddress ??
              (addressList.isNotEmpty ? addressList[0] : AddressModel()),
        );

      default:
        return Center(
          child: Column(
            children: [
              Image.asset(
                "assets/GIF/checkmark.png",
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              const Text(
                "Order Placed",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: secondary,
      ),
      drawer: const DrawerPage(),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SolidButton(
              label: "Back",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: renderSteps(),
              ),
            ),
            Expanded(flex: 7, child: renderPage())
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddressSelectionPage extends StatefulWidget {
  int? activeState;
  Function()? onNextStep;
  List<AddressModel> addressList;
  Function(dynamic)? onAddressSelect;
  String? addressId;
  AddressSelectionPage({
    super.key,
    this.activeState,
    this.onNextStep,
    this.addressList = const <AddressModel>[],
    this.onAddressSelect,
    this.addressId,
  });

  @override
  State<AddressSelectionPage> createState() => AddressSelectionPageState();
}

class AddressSelectionPageState extends State<AddressSelectionPage> {
  String? addressId = "";
  @override
  void initState() {
    super.initState();
    if (widget.addressList.isNotEmpty) {
      String tempAddressId = widget.addressList[0].addressUid!;
      widget.onAddressSelect!(tempAddressId);
      setState(() {
        addressId = tempAddressId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...widget.addressList
                    .map(
                      (e) => AddressCard(
                        onEditDone: () {},
                        addressId: addressId != ""
                            ? addressId
                            : (widget.addressList.isNotEmpty)
                                ? widget.addressList[0].addressUid!
                                : "",
                        select: true,
                        address: e,
                        onSelect: (value) {
                          widget.onAddressSelect!(value);
                        },
                      ),
                    )
                    .toList(),
                if (widget.addressList.isEmpty)
                  const Center(
                    child: Text("No Address found please add address first"),
                  )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.addressList.isNotEmpty)
                SolidButton(
                  onPressed: widget.onNextStep,
                  label: "Next",
                  color: secondary,
                ),
              if (widget.addressList.isEmpty)
                SolidButton(
                  onPressed: () {},
                  label: "Next",
                  color: gray,
                )
            ],
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class PaymentModeSelectionPage extends StatefulWidget {
  int? activeState;
  Function()? onNextStep;
  Function()? onBackStep;
  PaymentModeSelectionPage({
    super.key,
    this.activeState,
    this.onNextStep,
    this.onBackStep,
  });

  @override
  State<PaymentModeSelectionPage> createState() =>
      _PaymentModeSelectionPageState();
}

class _PaymentModeSelectionPageState extends State<PaymentModeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Payment Mode :",
                  style: TextStyle(
                    color: secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: 1,
                          onChanged: (value) {},
                          activeColor: secondary,
                        ),
                        const Text(
                          "Cash on delivery",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SolidButton(
                onPressed: widget.onBackStep,
                label: "Back",
                color: gray,
              ),
              SolidButton(
                onPressed: widget.onNextStep,
                label: "Next",
                color: secondary,
              )
            ],
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class FinalOrderPage extends StatefulWidget {
  int? activeState;
  Function()? onNextStep;
  Function()? onBackStep;
  List<CartModel> productList;
  AddressModel? selectedAddress;
  FinalOrderPage({
    super.key,
    this.activeState,
    this.onBackStep,
    this.onNextStep,
    this.productList = const <CartModel>[],
    this.selectedAddress,
  });

  @override
  State<FinalOrderPage> createState() => _FinalOrderPageState();
}

class _FinalOrderPageState extends State<FinalOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Order Details:",
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const VerticalSpace(
                                space: 8,
                              ),
                              TotalCard(productList: widget.productList),
                              const Divider(),
                              const Text(
                                "Delivery Address :",
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const VerticalSpace(
                                space: 8,
                              ),
                              if (widget.selectedAddress != null)
                                AddressCard(
                                  onEditDone: () {},
                                  showDelete: false,
                                  showEdit: false,
                                  address: widget.selectedAddress,
                                ),
                              const Divider(),
                              const Text(
                                "Payment Mode :",
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: 1,
                                        onChanged: (value) {},
                                        activeColor: secondary,
                                      ),
                                      const Text(
                                        "Cash on delivery",
                                        style: TextStyle(
                                          color: secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalSpace(
                                space: 8,
                              ),
                              const Divider(),
                              const VerticalSpace(
                                space: 8,
                              ),
                              const Text(
                                "Products :",
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ...widget.productList
                                  .map(
                                    (cartItem) => CartCard(
                                      cartRefresh: () {},
                                      count: cartItem.count,
                                      product: cartItem.product,
                                      showQtyUpdate: false,
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SolidButton(
                onPressed: widget.onBackStep,
                label: "Back",
                color: gray,
              ),
              SolidButton(
                onPressed: widget.onNextStep,
                label: "Place order",
                color: secondary,
              )
            ],
          ),
        )
      ],
    );
  }
}
