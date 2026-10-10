import 'package:flutter/material.dart';
import '../../models/transferencia.dart';
import 'formulario.dart';
import 'package:intl/intl.dart';
import '../../database/app_database.dart';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  static const _tituloAppBar = "Transferências";

  void _atualiza(Transferencia? transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: FutureBuilder<List<Transferencia>>(
        future: buscarTransferencias(), // busca no banco
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Erro ao carregar transferências.'),
                );
              }

              final transferencias = snapshot.data ?? [];
              if (transferencias.isEmpty) {
                return const Center(
                  child: Text('Nenhuma transferência encontrada.'),
                );
              }

              final formatador = NumberFormat.simpleCurrency(locale: 'pt_BR');

              return ListView.builder(
                itemCount: transferencias.length,
                itemBuilder: (context, index) {
                  final transferencia = transferencias[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.monetization_on,
                        color: Colors.green,
                      ),
                      title: Text(formatador.format(transferencia.valor)),
                      subtitle: Text('Conta: ${transferencia.numeroConta}'),
                    ),
                  );
                },
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Botão + pressionado");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          ).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    NumberFormat formato = NumberFormat.simpleCurrency();
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(formato.format(_transferencia.valor).toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}
