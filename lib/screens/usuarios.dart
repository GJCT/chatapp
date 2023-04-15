import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatapp/providers/provider.dart';
import 'package:chatapp/models/usuario.dart';

class UsuariosScreen extends StatefulWidget {
   
  const UsuariosScreen({Key? key}) : super(key: key);

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usuariosProvider = UsuariosProvider();

  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    final socketProvider = Provider.of<SocketProvider>(context);
    final usuario = authProvider.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre, style: const TextStyle(color: Colors.black54)),
        backgroundColor: const Color(0xaaA4F4F4),
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded, color: Colors.black54),
          onPressed: (){
            //Desconectarse del socket 
            socketProvider.disconnect();
            //Navegación al login al desconectarse
            Navigator.pushReplacementNamed(context, 'login');
            AuthProvider.logoutToken();
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketProvider.serverStatus == ServerStatus.Online) ? 
            Icon(Icons.check_circle_rounded, color: Colors.blue[300])
            : Icon(Icons.cancel_rounded, color: Colors.red[300]),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check_circle, color: Colors.green[600],),
          waterDropColor: Colors.black45,
        ),
        child: _viewUsuarios(),
      )
    );
  }

  ListView _viewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: ( _, i) => _listUsuario(usuarios[i]), 
      separatorBuilder: ( _, i) => const Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _listUsuario(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.correo),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2), style: const TextStyle(color: Colors.black54)),
          backgroundColor: const Color(0xaaA4F4F4),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadiusDirectional.circular(5)
          ),
        ),
        onTap: (){
          final chatProvider = Provider.of<ChatProvider>(context, listen: false);
          chatProvider.usuarioMsg = usuario;
          Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _cargarUsuarios() async{

    usuarios = await usuariosProvider.getUsuarios();
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}