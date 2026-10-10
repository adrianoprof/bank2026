import 'package:flutter/material.dart';
import './contatos/lista_contatos.dart';
import './transferencias/lista.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //alinhamento horizontal
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Image.asset("images/bytebank_logo.png"),
            
            const SizedBox(height: 8.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _FeatureItem(
                  nome: "Contatos",
                  icone: Icons.people,
                  onClick: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ListaContatos()
                      ),
                    );
                  },
                ),

                _FeatureItem(
                  nome: "Transferências",
                  icone: Icons.monetization_on,
                  onClick: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ListaTransferencias(),
                      ),
                    );
                  },
                )
              ],

            ),

              
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String nome;
  final IconData icone;
  final void Function() onClick;

  const _FeatureItem({
    required this.nome,
    required this.icone,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(12),

        child: Container(
          height: 120,
          width: 120,
          padding: const EdgeInsets.all(8),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
