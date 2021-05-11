var Usuario = function(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono) {
	this.rol = rol;
	this.nombre = nombre;
	this.apellidoPat = apellidoPat;
	this.apellidoMat = apellidoMat;
	this.contrasena = contrasena;
	this.email = email;
	this.telefono = telefono;
	//this.foto = foto;
};

Usuario.prototype = {	
	isValid: function() {
		if (!this.rol || !this.nombre || !this.apellidoPat || !this.apellidoMat || !this.contrasena || !this.email || !this.telefono) return false;
		return true;
	}
};

var UsuarioLogIn = function(rol, contrasena, email){
	this.rol = rol;
	this.contrasena = contrasena;
	this.email = email;
};

var ModificateUsuario = function(modNombre, modApellidoPat, modApellidoMat, modContrasena, modEmail, modTelefono){
	this.modNombre = modNombre;
	this.modApellidoPat = modApellidoPat;
	this.modApellidoMat = modApellidoMat;
	this.modContrasena = modContrasena;
	this.modEmail = modEmail;
	this.modTelefono = modTelefono;
}