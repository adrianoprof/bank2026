import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/transferencia.dart';
import '../../database/app_database.dart';


class FormularioTransferencia extends StatefulWidget {

  final int? numeroConta; // nova propriedade opcional
  const FormularioTransferencia({super.key, this.numeroConta}); // construtor com parâmetro


  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  static const _tituloAppBar = 'Criando transferência';
  static const _rotuloCampoValor = 'Valor';
  static const _dicaCampoValor = '0,00';

  static const _rotuloCampoNumeroConta = 'Número da conta';
  static const _dicaCampoNumeroConta = '0000';
  static const _textoBotaoConfirmar = 'Confirmar';

  @override

  void initState(){
    super.initState();

    if(widget.numeroConta != null){
      _controladorCampoNumeroConta.text = widget.numeroConta.toString();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tituloAppBar,        
        ),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
              tipoTeclado: TextInputType.number,
            ),

            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
              tipoTeclado: TextInputType.numberWithOptions(decimal:true),
            ),

            ElevatedButton(
              onPressed: () {
                debugPrint("Clicou aqui...");
                _criaTransferencia(
                  context,
                  _controladorCampoNumeroConta,
                  _controladorCampoValor,
                );
              },
              child: const Text(_textoBotaoConfirmar),
            ),
          ],
        ),
      ),
    );
  }
}

void _criaTransferencia(
  BuildContext context,
  TextEditingController controladorCampoNumeroConta,
  TextEditingController controladorCampoValor,
) {
  final int? numeroConta = int.tryParse(controladorCampoNumeroConta.text);
  final double? valor = double.tryParse(controladorCampoValor.text);

  if (numeroConta != null && valor != null) {
    final transferenciaCriada = Transferencia(valor, numeroConta);

    debugPrint('$transferenciaCriada'); // Teste de saída no console

    salvarTransferencia(transferenciaCriada).then((id){
      debugPrint('Transferência salva com id: $id');

      if (!context.mounted) return;

      Navigator.pop(context, transferenciaCriada);

    });


    
  }
}