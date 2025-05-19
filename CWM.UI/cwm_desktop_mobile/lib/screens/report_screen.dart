import 'package:cwm_desktop_mobile/models/report_work_order.dart';
import 'package:cwm_desktop_mobile/models/searches/report_work_order_search.dart';
import 'package:cwm_desktop_mobile/models/work_order_info.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import '../providers/work_order_provider.dart';

class IzvjestajScreen extends StatefulWidget {
  const IzvjestajScreen({super.key});

  @override
  State<IzvjestajScreen> createState() => _IzvjestajScreenState();
}

class _IzvjestajScreenState extends State<IzvjestajScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  late WorkOrderProvider workOrderProvider;
  ReportWorkOrder? reportResult;
  bool isLoading = true;
  ReportWorkOrderSearch? search;
  ReportWorkOrder? izvjestaj;
  bool isDataLoaded = false;
  DateTime? datumOd;
  DateTime? datumDo;

  Future getIzvjestaj() async {
    try {
      reportResult = await workOrderProvider.getServiceReport(search!);

      if (mounted) {
        setState(() {
          isDataLoaded = true;
        });
      }
    } on Exception catch (e) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    final img = await rootBundle.load('assets/images/logo.png');
    final imageBytes = img.buffer.asUint8List();

    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  color: PdfColor.fromHex("#DEDEDE"),
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          alignment: pw.Alignment.topLeft,
                          height: 65,
                          width: 65,
                          child: image1,
                        ),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text('Datum i vrijeme',
                                  style: pw.TextStyle(
                                      color: PdfColor.fromHex("#2B2B2B"))),
                              pw.SizedBox(height: 2.0),
                              pw.Text(formatDate(DateTime.now()),
                                  style: pw.TextStyle(
                                      color: PdfColor.fromHex("#424242"))),
                            ]),
                      ]),
                ),
                pw.SizedBox(height: 10.0),
                pw.Text(
                  'Izvjestaj narudzbi',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10.0),
                pw.Text(
                    datumOd != null && datumOd != null
                        ? '${formatDate1(datumOd)} - ${formatDate1(datumDo)}'
                        : 'Pregled izvjestaja za sve narudzbe',
                    textAlign: pw.TextAlign.center),
                pw.SizedBox(height: 20.0),
                pw.Container(
                  color: PdfColor.fromHex("#EBEBEB"),
                  padding: const pw.EdgeInsets.all(5.0),
                  child: pw.RichText(
                    text: pw.TextSpan(children: [
                      const pw.TextSpan(text: 'Najvise prodavan proizvod: '),
                      pw.TextSpan(
                          text: reportResult!.total.toString(),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]),
                  ),
                ),
                pw.SizedBox(height: 15.0),
                pw.Container(
                  margin: const pw.EdgeInsets.only(left: 70.0),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      /*pw.Expanded(
                        child: pw.Text(
                          'Broj narudzbe',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),*/
                      pw.Expanded(
                        child: pw.Text(
                          'Servis',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'Kupac',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Text(
                        'Iznos',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                pw.Divider(height: 5.0, color: PdfColor.fromHex("#9E9E9E")),
                pw.ListView.builder(
                  itemCount: reportResult!.workOrderInfo.length,
                  itemBuilder: (context, index) {
                    WorkOrderInfo workOrderInfo =
                        reportResult!.workOrderInfo[index];
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                          DateFormat('MMMM d y')
                              .format(workOrderInfo.workOrderDate),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        for (var item in workOrderInfo.serviceReports)
                          pw.Container(
                            margin: const pw.EdgeInsets.only(left: 70.0),
                            padding: const pw.EdgeInsets.only(bottom: 3.0),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                /*pw.Expanded(
                                  child: pw.Text(
                                    item.servicePerformed.name,
                                  ),
                                ),*/
                                pw.Expanded(
                                  child: pw.Text(
                                    item.servicePerformed.name,
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    '${item.employee.firstName} ${item.employee.lastName}',
                                  ),
                                ),
                                pw.Text(
                                  '${formatNumber(item.totalTime)} H',
                                ),
                              ],
                            ),
                          ),
                        pw.Container(
                          margin: const pw.EdgeInsets.only(left: 70.0),
                          child: pw.Divider(
                              height: 10.0, color: PdfColor.fromHex("#9E9E9E")),
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              margin: const pw.EdgeInsets.only(left: 70.0),
                              child: pw.Text(
                                'Ukupno za ${DateFormat('MMMM d y').format(workOrderInfo.workOrderDate)}:',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Container(
                              child: pw.Text(
                                '${formatNumber(reportResult!.totalHours)} KM',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 20.0),
                      ],
                    );
                  },
                ),
                pw.SizedBox(
                  height: 10.0,
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8.0),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'UKUPNO:',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        '${formatNumber(reportResult!.totalHours)} KM',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    final directory = await getDownloadsDirectory();
    final path =
        '${directory?.path}/${"Izvještaj_narudzbi ${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().millisecondsSinceEpoch}.pdf"}';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // ignore: use_build_context_synchronously
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.blue.shade50,
              title: const Icon(
                Icons.save_alt,
                size: 38,
              ),
              content: Text(
                'PDF has been saved to: $path',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      OpenFile.open(file.path);
                    },
                    child: const Text(
                      'OK',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    workOrderProvider = context.read<WorkOrderProvider>();
    search = ReportWorkOrderSearch();
    search?.dateFrom = DateTime(2024, 4, 4, 0, 0, 0, 0, 0).toIso8601String();
    search?.dateTo = DateTime(2025, 5, 5, 0, 0, 0, 0, 0).toIso8601String();
    getIzvjestaj();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izvještaj'),
      ),
      body: Center(
        child: isDataLoaded
            ? ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        'Datum od:',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'datumOd',
                          initialValue: datumOd,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                            prefixIcon: const Icon(Icons.date_range),
                            labelText: 'Odaberite datum',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _formKey.currentState!.fields['datumOd']
                                    ?.didChange(null);
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                          inputType: InputType.date,
                          format: DateFormat("yyyy-MM-dd"),
                          onChanged: (DateTime? newDate) {
                            setState(() {
                              search?.dateFrom = newDate.toString();
                              datumOd = newDate;
                              getIzvjestaj();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        'Datum do:',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'datumDo',
                          initialValue: datumDo,
                          //resetIcon: null,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                            prefixIcon: const Icon(Icons.date_range),
                            labelText: 'Odaberite datum',
                            floatingLabelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _formKey.currentState!.fields['datumDo']
                                    ?.didChange(null);
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                          inputType: InputType.date,
                          format: DateFormat("yyyy-MM-dd"),
                          onChanged: (DateTime? newDate) {
                            setState(() {
                              search?.dateTo = newDate.toString();
                              datumDo = newDate;
                              getIzvjestaj();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  buildInfoCard(
                    title: "Statistike",
                    items: [
                      InfoItem(
                          "Ukupno korisnika", reportResult!.total.toString()),
                      InfoItem("Broj doktora", reportResult!.total.toString()),
                      InfoItem(
                          "Broj pacijenata", reportResult!.total.toString()),
                      InfoItem(
                          "Broj rezervacija", reportResult!.total.toString()),
                      InfoItem("Broj aktivnih rezervacija",
                          reportResult!.total.toString()),
                      InfoItem("Broj neaktivnih rezervacija",
                          reportResult!.total.toString()),
                      InfoItem("Broj nalaza", reportResult!.total.toString()),
                      InfoItem(
                          "Broj poklon bonova", reportResult!.total.toString()),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showConfirmationDialog(context, generatePDF);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/pdf.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                              width:
                                  8), // Optional space between image and text
                          Text('Snimi PDF'),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  Future<void> showConfirmationDialog(
      BuildContext context, VoidCallback onConfirm) async {
    bool? shouldOpen = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda'),
          content: Text('Da li želite otvoriti PDF fajl?'),
          actions: [
            TextButton(
              onPressed: () async {
                await generatePDF();
              },
              child: Text('DA'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('NE'),
            ),
          ],
        );
      },
    );

    if (shouldOpen != null && shouldOpen) {
      // If the user selected 'DA', then call the exportToPdf function
      onConfirm();
    }
  }

  Widget buildInfoCard({required String title, required List<InfoItem> items}) {
    return Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
              SizedBox(height: 12.0),
              if (reportResult!.workOrderInfo.isEmpty)
                Container(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Text(
                      'Nema narudžbi za datume u intervalu: [ ${formatDate1(datumOd)} - ${formatDate1(datumDo)} ]',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: reportResult!.workOrderInfo.length,
                    itemBuilder: (BuildContext context, int index) {
                      WorkOrderInfo workOrderInfo =
                          reportResult!.workOrderInfo[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('MMMM d y')
                                .format(workOrderInfo.workOrderDate),
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                          for (var item in workOrderInfo.serviceReports)
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 110.0, right: 110.0),
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.servicePerformed.name,
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.startTime.toString(),
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${item.employee.firstName} ${item.employee.lastName}',
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Text(
                                    '${formatNumber(item.totalTime)} H',
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 110.0, right: 110.0),
                            child: const Divider(
                              height: 20.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 110.0),
                                child: Text(
                                  'Ukupno za ${DateFormat('MMMM d y').format(workOrderInfo.workOrderDate)}:',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 110.0),
                                child: Text(
                                  '${formatNumber(reportResult!.totalHours)} H',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 50.0,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(border: Border.all()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'UKUPNO:',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${formatNumber(reportResult!.totalHours)} SATI',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

        /*Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return buildInfoItem(item.label, item.value);
              }).toList(),
            ),*/
        //],
        //),
        );
  }

  Widget buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoItem {
  final String label;
  final String value;

  InfoItem(this.label, this.value);
}
