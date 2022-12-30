/*
GM base by KRISSTI4N
Contiene:
-Registro
-Ingreso
-Guardado automatico de informacion
-Cargado automatico de informacion

if(cache_num_rows()){
new str[36+1];

format(str, sizeof(str), "%sescribe una contraseña para ingresar", str);

ShowPlayerDialog(playerid, 8601, DIALOG_STYLE_PASSWORD, "login>contraseña", str, ">", "--");
 }else{
new str[40+1];

format(str, sizeof(str), "%sescribe una contraseña para registrarte.", str);

ShowPlayerDialog(playerid, DIALOGO_REGISTRO, DIALOG_STYLE_PASSWORD, "registro>contraseña", str, ">", "--");

 }
*/

//Includes
#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <sscanf2>
#include <zcmd>

//Configuracion
#define MYSQL_HOSTNAME		"localhost" // Change this to your own MySQL hostname
#define MYSQL_USERNAME		"root" // Change this
#define MYSQL_PASSWORD		"" // If you have a password, type it there. If you don't leave it blank.
#define MYSQL_DATABASE		"s.v 1" // Change this
//Colores
#define VERDECLARO 0x00FF00FF
//Atajos
#define SCM SendClientMessage
#define SPP SetPlayerPos
//Dialogos
#define DIALOG_REGISTRO   0
#define DIALOG_GENERO     1
#define DIALOG_EDAD       2
#define DIALOG_INGRESO    3
//news
new MySQL;
//Enum
enum jInfo
{
Contra[128],
Genero,
Edad,
Ropa,
Float:X,
Float:Y,
Float:Z,
Float:Vida,
Float:Chaleco,
Muertes,
Asesinatos,
Faccion,
Rango,
Trabajo,
Dinero,
Interior,
VW,
Nivel
}
new Jugador[MAX_PLAYERS][jInfo];
//Forward
forward VerificarUsuario(playerid);
forward CrearCuenta(playerid);
forward IngresoJugador(playerid);
forward IngresarJugador(playerid);
forward GuardarJugador(playerid);
//
main()
{
print("GM base creada por KRISSTI4N - 2015");
}
public OnGameModeInit()
{
	new MySQLOpt: option_id = mysql_init_options();
 
	mysql_set_option(option_id, AUTO_RECONNECT, true); // it automatically reconnects when loosing connection to mysql server
 
	MySQL = mysql_connect(MYSQL_HOSTNAME, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE, option_id); // AUTO_RECONNECT is enabled for this connection handle only
	if (MySQL == MYSQL_INVALID_HANDLE || mysql_errno(MySQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down."); // Read below
		SendRconCommand("exit"); // close the server if there is no connection
		return 1;
	}
 
	SetGameModeText("SERVER VERSION");
	print("MySQL connection is successful."); // If the MySQL connection was successful, we'll print a debug!
	return 1;

}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
   new query[520],nombre[MAX_PLAYER_NAME];
   GetPlayerName(playerid, nombre, sizeof(nombre));
   mysql_format(MySQL, query, sizeof(query), "SELECT * FROM cuentas WHERE `Nombre`='%s' LIMIT 1", nombre);
   mysql_pquery(MySQL, query, "VerificarUsuario","d", playerid);

   return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    GuardarJugador(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	Jugador[playerid][Muertes]++;
	Jugador[killerid][Asesinatos]++;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	//
	case DIALOG_REGISTRO:
	{
        if(response)
		{
		new contra[128];
		SCM(playerid, VERDECLARO, "�Bien!{ffffff} Continuemos con el registro.");
		ShowPlayerDialog(playerid, DIALOG_GENERO, DIALOG_STYLE_MSGBOX, "Genero", "Seleccione su genero.", "Masculino", "Femenino");
		format(contra,sizeof(contra),"%s",inputtext);
		Jugador[playerid][Contra] = contra;
		}
		else
		{
		Kick(playerid);
		}
    }
    //
	case DIALOG_GENERO:
	{
		if(response)
		{
		Jugador[playerid][Genero] = 0;
		Jugador[playerid][Ropa] = 46;
		SCM(playerid,-1,"Has seleccionado {FFFF00}masculino{FFFFFF}.");
		ShowPlayerDialog(playerid, DIALOG_EDAD, DIALOG_STYLE_INPUT, "Edad", "Ingrese su edad\n\nMinimo 18 - Maximo 90.", "Continuar", "Cancelar");
		}
		else
		{
		Jugador[playerid][Genero] = 1;
		Jugador[playerid][Ropa] = 12;
		SCM(playerid,-1,"Has seleccionado {FFFF00}femenino{FFFFFF}.");
		ShowPlayerDialog(playerid, DIALOG_EDAD, DIALOG_STYLE_INPUT, "Edad", "Ingrese su edad\n\nMinimo 8 - Maximo 90.", "Continuar", "Cancelar");
		}
	  }
	//
	case DIALOG_EDAD:
	{
	     if(response)
		 {
		 if(strval(inputtext) < 8 || strval(inputtext) > 100) return ShowPlayerDialog(playerid, DIALOG_EDAD, DIALOG_STYLE_INPUT, "Edad", "Ingrese su edad\n\n{FF0000}Minimo 18 - Maximo 90.", "Continuar", "Cancelar");
		 Jugador[playerid][Edad] = strval(inputtext);
		 SetSpawnInfo(playerid, 0, Jugador[playerid][Ropa], 1484.1082, -1668.4976, 14.9159, 0.0000, 0,0,0,0,0,0);
		 SetPVarInt(playerid, "PuedeIngresar", 1);
		 SpawnPlayer(playerid);
		 CrearCuenta(playerid);
	     }
		 else
		 {
		 Kick(playerid);
		 }
	}
	//
	case DIALOG_INGRESO:
	{
        if(response)
		{
		new query[520];
		mysql_format(MySQL,query,sizeof(query),"SELECT * FROM `cuentas` WHERE `Nombre`='%s' AND `Contra`='%s'",NombreJugador(playerid),inputtext);
		mysql_pquery(MySQL, query, "IngresoJugador","d", playerid);
		}
		else
		{
		Kick(playerid);
		}
	}
	//
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
public VerificarUsuario(playerid)
{
	//SendClientMessage(playerid, 0,"verificar usuario");
if(!cache_num_rows())    {
    CamaraInicio(playerid);
	ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Registro", "Bienvenido\n\nIngrese una contrase�a para registrarse.", "Registrar", "Cancelar");
	}
	else
	{
	CamaraInicio(playerid);
	ShowPlayerDialog(playerid, DIALOG_INGRESO, DIALOG_STYLE_INPUT, "Ingreso", "Bienvenido\n\nIngrese su contrase�a para ingresar.", "Continuar", "Cancelar");
	}
	return 1;
}
stock CamaraInicio(playerid)
{
SetPlayerCameraPos(playerid, 1533.2587, -1763.7717, 73.6204);
SetPlayerCameraLookAt(playerid, 1532.9288, -1762.8286, 73.0504);
SetPlayerPos(playerid,1513.4531, -1782.2853, 68.0610);
TogglePlayerControllable(playerid,0);
return 1;
}
stock NombreJugador(playerid)
{
new nombre[MAX_PLAYER_NAME];
GetPlayerName(playerid, nombre, sizeof(nombre));
return nombre;
}
public CrearCuenta(playerid)
{
new query[520],aviso[125];
mysql_format(MySQL, query, sizeof(query), "INSERT INTO cuentas(Nombre, Contra, Ropa, X, Y, Z, Genero, vida, Dinero) VALUES ('%s','%s',%d,'1484.1082', '-1668.4976', '14.9159',%d,'100','100000')",
NombreJugador(playerid),
Jugador[playerid][Contra],
Jugador[playerid][Ropa],
Jugador[playerid][Genero]);
mysql_query(MySQL, query);
SCM(playerid,VERDECLARO,"�Felicitaciones! Registro completo.");
SCM(playerid,-1,"Has completado el resgistro, bienvenido a el servidor, disfruta tu estadia.");
SCM(playerid,-1, "Has recibido una bonificacion extra en tu cuenta por estar en nuestro comienzo.");
format(aviso,sizeof(aviso),"Cuenta creada: %s - Edad: %d - Genero: %d", NombreJugador(playerid), Jugador[playerid][Edad], Jugador[playerid][Genero]);
print(aviso);
return 1;
}

public IngresoJugador(playerid)
{
if(!cache_num_rows()){
ShowPlayerDialog(playerid, DIALOG_INGRESO, DIALOG_STYLE_INPUT, "Ingreso", "�Error!\n\nLa contrase�a no es correcta.", "Continuar", "Cancelar");
}
else
{
cache_get_value_name_int(0, "Ropa", Jugador[playerid][Ropa]);
cache_get_value_name_float(0, "X", Jugador[playerid][X]);
cache_get_value_name_float(0, "Y", Jugador[playerid][Y]);
cache_get_value_name_float(0, "Z", Jugador[playerid][Z]);
cache_get_value_name_int(0, "Genero", Jugador[playerid][Genero]);
cache_get_value_name_float(0, "Vida", Jugador[playerid][Vida]);
cache_get_value_name_float(0, "Chaleco", Jugador[playerid][Chaleco]);
cache_get_value_name_int(0, "Muertes", Jugador[playerid][Muertes]);
cache_get_value_name_int(0, "Asesinatos", Jugador[playerid][Asesinatos]);
cache_get_value_name_int(0, "Faccion", Jugador[playerid][Faccion]);
cache_get_value_name_int(0, "Rango", Jugador[playerid][Rango]);
cache_get_value_name_int(0, "Trabajo", Jugador[playerid][Trabajo]);
cache_get_value_name_int(0, "Dinero", Jugador[playerid][Dinero]);
cache_get_value_name_int(0, "Interior", Jugador[playerid][Interior]);
cache_get_value_name_int(0, "VW", Jugador[playerid][VW]);
cache_get_value_name_int(0, "Edad", Jugador[playerid][Edad]);
IngresarJugador(playerid);
}
return 1;
}
public IngresarJugador(playerid)
{
SetSpawnInfo(playerid, 0, Jugador[playerid][Ropa], Jugador[playerid][X],Jugador[playerid][Y],Jugador[playerid][Z], 0.0000, 0,0,0,0,0,0);
SpawnPlayer(playerid);
SetPlayerHealth(playerid,Jugador[playerid][Vida]);
SetPlayerArmour(playerid,Jugador[playerid][Chaleco]);
GivePlayerMoney(playerid,Jugador[playerid][Dinero]);
SetPlayerVirtualWorld(playerid,Jugador[playerid][VW]);
SetPlayerInterior(playerid,Jugador[playerid][Interior]);
SetPlayerSkin(playerid,Jugador[playerid][Ropa]);
print("su skin es %d",Jugador[playerid][Ropa]);
return 1;
}
public GuardarJugador(playerid)
{
new query[520],Float:jX,Float:jY,Float:jZ,Float:hp,Float:chale,pVW,pInt;
GetPlayerPos(playerid, jX, jY, jZ);
GetPlayerHealth(playerid,hp);
GetPlayerArmour(playerid,chale);
Jugador[playerid][VW] = GetPlayerVirtualWorld(playerid);
Jugador[playerid][Interior] = GetPlayerInterior(playerid);
pVW = GetPlayerVirtualWorld(playerid);
pInt = GetPlayerInterior(playerid);
mysql_format(MySQL, query, sizeof(query), "UPDATE `cuentas` SET `Ropa`=%d,`X`=%f,`Y`=%f,`Z`=%f,`Genero`=%d,`Vida`=%f,`Chaleco`=%f,`Muertes`=%d,`Asesinatos`=%d WHERE `Nombre`='%s'",
Jugador[playerid][Ropa],
jX,
jY,
jZ,
Jugador[playerid][Genero],
hp,
chale,
Jugador[playerid][Muertes],
Jugador[playerid][Asesinatos],
NombreJugador(playerid));
mysql_query(MySQL, query);
//
mysql_format(MySQL, query, sizeof(query), "UPDATE `cuentas` SET `Edad`=%d, `Faccion`=%d, `Rango`=%d, `Trabajo`=%d, `Dinero`=%d WHERE `Nombre`='%s'",
Jugador[playerid][Edad],
Jugador[playerid][Faccion],
Jugador[playerid][Rango],
Jugador[playerid][Trabajo],
Jugador[playerid][Dinero],
NombreJugador(playerid));
mysql_query(MySQL, query);

mysql_format(MySQL, query, sizeof(query), "UPDATE `cuentas` SET `VW`='%i', `Interior`='%i' WHERE `Nombre`='%s'",
pVW,
pInt,
NombreJugador(playerid));
mysql_query(MySQL, query);

return 1;
}
/*public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	switch(errorid)
	{
		case CR_SERVER_GONE_ERROR:
		{
			printf("Conexion perdida..");
			mysql_reconnect(connectionHandle);
		}
		case ER_SYNTAX_ERROR:
		{
			printf("Error en el sintaxis de la consulta: %s",query);
		}
	}
	return 1;
}
stock MensajeFaccion(fid, color, mensaje[])
{
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(Jugador[i][Faccion] == fid)
{
SCM(i,color,mensaje);
}
}
return 1;
}
*/