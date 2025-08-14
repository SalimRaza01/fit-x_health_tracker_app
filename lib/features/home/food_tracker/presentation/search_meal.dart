import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fit_x/core/constants/app_colors.dart';

final List<Map<String, dynamic>> foodList = [
  {
    "name": "Toned Milk",
    "quantity": 400,
    "measure": "ml",
    "calories": 245,
    "protein": 8.0,
    "fats": 4.8,
    "carbs": 12.0,
    "fiber": 0.0,
  },
  {
    "name": "Full Cream Milk",
    "quantity": 450,
    "measure": "ml",
    "calories": 300,
    "protein": 9.0,
    "fats": 8.0,
    "carbs": 15.0,
    "fiber": 0.0,
  },
  {
    "name": "Cow Milk",
    "quantity": 432,
    "measure": "ml",
    "calories": 280,
    "protein": 8.5,
    "fats": 5.0,
    "carbs": 13.0,
    "fiber": 0.0,
  },
];

class SearchMealScreen extends StatefulWidget {
  const SearchMealScreen({super.key});

  @override
  State<SearchMealScreen> createState() => _SearchMealScreenState();
}

class _SearchMealScreenState extends State<SearchMealScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = foodList
        .where(
            (food) => food["name"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColor.backgroundLineartop,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundLineartop,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: Color(0xffBABABA),
          ),
        ),
        title: const Text(
          "SEARCH MEAL",
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.backgroundLineartop,
              AppColor.backgroundLinearbottom,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search Meal",
                  hintStyle: const TextStyle(color: Color(0xffBABABA)),
                  prefixIcon: const Icon(Icons.search,
                      color: Color(0xffBABABA), size: 20),
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xffBABABA), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Color(0xffBABABA), width: 0.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
                onChanged: (value) {
                  setState(() => query = value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  var food = filteredList[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color(0xff2A2A2A), width: 0.8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food["name"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${food["quantity"]}${food["measure"]}",
                              style: const TextStyle(
                                color: Color(0xffBABABA),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${food["calories"]} Cal",
                              style: const TextStyle(
                                color: Color(0xffBABABA),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) => CustomizeMealSheet(
                                      food: food,
                                    ),
                                  );
                                },
                                child: Icon(Icons.add,
                                    color: Colors.white, size: 20)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  context.push('/foodMainScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white10,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white38),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "ADD MEAL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomizeMealSheet extends StatefulWidget {
  final Map<String, dynamic> food;
  const CustomizeMealSheet({super.key, required this.food});

  @override
  State<CustomizeMealSheet> createState() => _CustomizeMealSheetState();
}

class _CustomizeMealSheetState extends State<CustomizeMealSheet> {
  double quantity = 0;
  String measure = "ML";

  @override
  void initState() {
    super.initState();
    quantity = widget.food["quantity"].toDouble();
    measure = widget.food["measure"].toString().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    double factor = quantity / widget.food["quantity"];
    double calories = widget.food["calories"] * factor;
    double protein = widget.food["protein"] * factor;
    double fats = widget.food["fats"] * factor;
    double carbs = widget.food["carbs"] * factor;
    double fiber = widget.food["fiber"] * factor;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff151A1E),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.food["name"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<double>(
                    value: quantity,
                    dropdownColor: const Color(0xff2B3035),
                    style: const TextStyle(color: Colors.white),
                    items: [100, 200, 300, 400, 450, 500]
                        .map((q) => DropdownMenuItem(
                              value: q.toDouble(),
                              child: Text(q.toString(),
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        quantity = val ?? widget.food["quantity"].toDouble();
                      });
                    },
                    decoration: _dropdownDecoration("Quantity"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: measure,
                    dropdownColor: const Color(0xff2B3035),
                    style: const TextStyle(color: Colors.white),
                    items: ["ML", "G", "PCS"]
                        .map((m) => DropdownMenuItem(
                              value: m,
                              child: Text(m,
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() => measure = val ?? "ML");
                    },
                    decoration: _dropdownDecoration("Measure"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Macronutrients Breakdown",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff2B3035),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${calories.toStringAsFixed(0)} Cal",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Divider(color: Color(0xff3A3F44), thickness: 1),
                  _macroRow("Protein", "${protein.toStringAsFixed(1)} g"),
                  _macroRow("Fats", "${fats.toStringAsFixed(1)} g"),
                  _macroRow("Carbs", "${carbs.toStringAsFixed(1)} g"),
                  _macroRow("Fiber", "${fiber.toStringAsFixed(1)} g"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${widget.food["name"]} added!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2ECC71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "ADD",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xffBABABA)),
      filled: true,
      fillColor: const Color(0xff2B3035),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _macroRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xffBABABA))),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
