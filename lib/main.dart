import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercado/screen/add_product.dart';
import 'package:mercado/screen/item_details.dart';
import 'package:mercado/screen/login.dart';
import 'package:mercado/screen/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model/product.dart';
import 'screen/home.dart';
import 'view_model/general_provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (ctx) => GeneralProvider(),
      child: Builder(
        builder: (ctx) => MaterialApp(
          themeMode: Provider.of<GeneralProvider>(ctx).isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark().copyWith(
            accentColor: Colors.grey,
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                headline6: GoogleFonts.anton(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                headline5: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                headline3: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                headline4: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            textTheme: TextTheme(
              bodyText2: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.black,
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                headline6: GoogleFonts.anton(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                headline5: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                headline3: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                headline4: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            textTheme: TextTheme(
              bodyText2: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          initialRoute: Splash.id,
          routes: {
            Home.id: (ctx) => Home(),
            Login.id: (ctx) => Login(),
            Splash.id: (ctx) => Splash(),
          },
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == ItemDetails.id) {
              final String productId = settings.arguments;
              return MaterialPageRoute<bool>(
                builder: (ctx) => ItemDetails(
                  productId: productId,
                ),
              );
            } else if (settings.name == AddProduct.id) {
              final Product product = settings.arguments;
              return MaterialPageRoute(
                builder: (ctx) => AddProduct(p: product),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
