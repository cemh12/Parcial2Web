<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Create - parcial2web</title>

    <script src="https://unpkg.com/dexie@latest/dist/dexie.js"></script>
    <link rel="stylesheet" type="text/css" href="../bootstrap/dist/css/bootstrap.css"/>
    <#--<link rel="stylesheet" type="text/css" href="../css/site.css" />-->


</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">parcial2web</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a onclick="mostrarTabla()">Lista</a></li>
                <li><a >Registrar</a></li>
                <li><a onclick="eliminar(25)">Eliminar</a></li>
                <li><a id="sincronizar" onclick="sincronizar()">Sincronizar</a></li>
            </ul>

        </div>
    </div>
</nav>

<script>
    (function () {
        document.querySelector("#cookieConsent button[data-cookie-string]").addEventListener("click", function (el) {
            document.cookie = el.target.dataset.cookieString;
            document.querySelector("#cookieConsent").classList.add("hidden");
        }, false);
    })();
</script>


<div class="container body-content">
    <div id="map" style="height: 500px;"></div>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCO_2zd9toMneUXrCsYxo5mzHqxJ5Bg5g8&callback=initMap">
    </script>
    <hr/>
            <form id="form">

                <div class="form-group">
                    <label class="control-label" for="Nombre">Nombre</label>
                    <input class="form-control" type="text" id="Nombre" name="Nombre" value=""/>
                    <span class="text-danger field-validation-valid" data-valmsg-for="Nombre"
                          data-valmsg-replace="true"></span>
                </div>
                <div class="form-group">
                    <label class="control-label" for="Sector">Sector</label>
                    <input class="form-control" type="text" id="Sector" name="Sector" value=""/>
                    <span class="text-danger field-validation-valid" data-valmsg-for="Sector"
                          data-valmsg-replace="true"></span>
                </div>
                <div class="form-group">
                    <label class="control-label" for="NivelAcademico">NivelAcademico</label>
                    <input class="form-control" type="text" id="NivelAcademico" name="NivelAcademico" value=""/>
                    <span class="text-danger field-validation-valid" data-valmsg-for="NivelAcademico"
                          data-valmsg-replace="true"></span>
                </div>
                <div class="form-group">
                    <input type="submit" value="Create" class="btn btn-default"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
                <input name="__RequestVerificationToken" type="hidden"
                       value="CfDJ8FOIdKNfwHdLtkScnM06FRe4wlzzl9dxY39Vh4uFIbULJdjsLuGkc8x4t4arG4vyEUDlHHm0HyJqZfDyc44Up4MwuIrAFTQG5f3aYUzofPCywLh0gdym48XzfowSOePxPJpWhpR5BIYefmMFGjmLl2c"/>
            </form>
    <div id="modalEditar" class="modal" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modificar encuesta</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body editarFormulario">
                    <form id="formModificar">
                        <input id="id" type="text" hidden>
                        <div class="field">
                            <label for="nombreModificar">Nombre</label>
                            <input type="text" name="nombre" required id="nombreModificar"/>
                        </div>
                        <div class="field ">
                            <label for="sectorModificar">Sector</label>
                            <input type="text" id="sectorModificar" required/>
                        </div>
                        <div class="field">
                            <label for="nivelEscolarModificar">Nivel Escolar</label>

                            <<input type="text" id="nivelEscolarModificar" required/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Cerrar</button>
                    <button id="modificar" onclick="modificarPersona()" type="button" class="btn btn-primary btn-sm">Guardar cambios</button>
                </div>
            </div>
        </div>
    </div>
            <table id="tabla" class="display" style="width:100%">

                <thead>
                </thead>
            </table>
    <hr/>
    <footer>
    </footer>
</div>


<script src="../jquery/dist/jquery.js"></script>
<script src="../bootstrap/dist/js/bootstrap.js"></script>
<script src="js/site.js?v=4q1jwFhaPaZgr8WAUSrux6hAuh0XDg9kPS3xIVq36I0"></script>


<script src="../jquery-validation/dist/jquery.validate.js"></script>
<script src="../jquery-validation-unobtrusive/jquery.validate.unobtrusive.js"></script>


<script>

    let posicion = [], latitud, longitud;
    $(document).ready(function () {
        let options = {
            enableHighAccuracy: false,
            timeout: 30000,      //30 segundos
            maximumAge: 360000   //1 hora
        };
        $("#form").submit(function () {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(gotPos);
            }
            enviarFormulario();
            return false;
        });
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(gotPos);
        }
    });

    function gotPos(position) {

        latitud = position.coords.latitude;
        longitud = position.coords.longitude;
        posicion = [{latitude: position.coords.latitude, longitude: position.coords.longitude}];
    }

    function posFail(err) {
        let errors = {
            1: 'No permission',
            2: 'Unable to determine',
            3: 'Took too long'
        };
    }

    function enviarFormulario() {
        let db = new Dexie("personas");
        db.version(1).stores({
            persona: '++id,nombre,sector, nivelEscolar, latitud, longitud'
        });


        console.log($('#Nombre'));

        db.persona.add({
            nombre: $('#Nombre').val(),
            sector: $('#Sector').val(),
            nivelAcademico: $('#NivelAcademico').val(),
            latitud: latitud,
            longitud: longitud,
            sincronizado: false,
        });
        alert("Guardado "+latitud+" "+longitud);
        mostrarTabla();
        initMap();
        document.getElementById("form").reset();
    }

    async function buscarPersonas() {
        let db = new Dexie("personas");
        db.version(1).stores({
            persona: '++id,nombre,sector, nivelEscolar, latitud, longitud, sincronizado'
        });
        return await db.persona.toArray().catch(function (err) {
            console.log(err);
        });
    }

    function sincronizar() {
        let datos = [];
        let personas = buscarPersonas().then(function (results) {
            console.log(results);
            results.forEach(function (data) {
                if (data.sincronizado === false) {
                    datos.push({
                        id: data.id,
                        nombre: data.nombre,
                        sector: data.sector,
                        nivelAcademico: data.nivelAcademico,
                        longitud: data.longitud,
                        latitud: data.latitud
                    });
                }
            });
            $.ajax({
                type: 'POST',
                data: JSON.stringify(datos),
                contentType: "application/json",
                url: '/sincronizar',
                success: function (response) {
                    let db = new Dexie("personas");
                    db.version(1).stores({
                        persona: '++id,nombre,sector, nivelAcademico, latitud, longitud, sincronizado'
                    });
                    db.persona.toCollection().modify(function (persona) {
                        persona.sincronizado = true;
                    });
                    initMap();

                }
            })
        });
    }

    var map;

    function initMap() {


        // Loop through the results array and place a marker for each
        // set of coordinates.
        buscarPersonas().then(function (results) {
            map = new google.maps.Map(document.getElementById('map'), {
                zoom: 12,
                center: new google.maps.LatLng(results[0].latitud, results[0].longitud),
                mapTypeId: 'terrain'
            });
            results.forEach(function (data) {
                var latLng = new google.maps.LatLng(data.latitud, data.longitud);
                var marker = new google.maps.Marker({
                    position: latLng,
                    map: map
                });
            })

        });
    }

    function mostrarTabla() {
        buscarPersonas().then(function (results) {
            var tableHeader = "<table><tr><th>Nombre</th><th>Sector</th><th>Nivel Academico</th><th>Latitud</th><th>Longitud</th><th>Sincronizado</th><th>Acciones<th></tr>";
            var tableContent = "";
            results.forEach(function (data) {
                tableContent = tableContent + "<tr><td>" + data.nombre + "</td><td>" + data.sector + "</td><td>" + data.nivelAcademico + "</td><td>" + data.latitud + "</td><td>" + data.longitud + "</td><td>" + data.sincronizado + "</td><td><a onclick=\"eliminar("+data.id+")\">Eliminar<a/></td><td><a onclick=\"modalEditar("+data.id+")\">Editar<a/></td></tr>";
                });
            var tableFooter = "</table>";
            document.getElementById("tabla").innerHTML = tableHeader + tableContent + tableFooter;
            });
    }

    function eliminar(id) {
        let num = id;
        let db = new Dexie("personas");
        db.version(1).stores({
            persona: '++id,nombre,sector, nivelAcademico, latitud, longitud, sincronizado'
        });
        db.persona.delete(parseInt(num));
        mostrarTabla();
        initMap();
    }
    function Editar(id) {
        let num = id;
        id = parseInt(num);
        $('#editar')[0].reset();
        let db = new Dexie("personas");
        db.version(1).stores({
            persona: '++id,nombre,sector, nivelAcademico, latitud, longitud, sincronizado'
        });
        db.persona.get(parseInt(num), function (data) {
            $('#NombreEditar').val(data.nombre);
            $('#SectorEditar').val(data.sector);
            $('#NivelAcademicoEditar').val(data.nivelAcademico);
            $('#idEditar').val(data.id);
            $('#LatitudEditar').val(data.latitud);
            $('#LongitudEditar').val(data.longitud);
            $('#SincronizadoEditar').val(data.sincronizado);
        });
        $('#EditarModal').modal('show');
    }
    function Actualizar() {
        let num = $('#idEditar').val();
        let db = new Dexie("personas");
        db.version(1).stores({
            persona: '++id,nombre,sector, nivelAcademico, latitud, longitud, sincronizado'
        });
        db.persona.update(parseInt(num), {
            id :$('#').val(),
            nombre: $('#NombreEditar').val(),
            sector: $('#SectorEditar').val(),
            nivelAcademico: $('#NivelAcademicoEditar').val(),
            latitud: $('#LatitudEditar').val(),
            longitud: $('#LongitudEditar').val(),
            sincronizado: $('#SincronizadoEditar').val()
        }).then(function (updated) {
            if (updated) {
                alert("Actualizado");
                mostrarTabla();
                $('Editar').modal('hide');
            } else
                console.log("Fallo");
        });
        mostrarTabla();
        initMap();
    }
    function modalEditar(id) {
        let num = id;
        id = parseInt(num);
        $('#formModificar')[0].reset();
        let db = new Dexie("personas");
        db.version(1).stores({
            persona: '++id,nombre,sector, nivelAcademico, latitud, longitud, sincronizado'
        });
        db.persona.get(parseInt(num), function (data) {
            $('#nombreModificar').val(data.nombre);
            $('#sectorModificar').val(data.sector);
            $('#nivelEscolarModificar').val(data.nivelAcademico);
            $('#id').val(id);
        });
        $('#modalEditar').modal('show');
    }
    function modificarPersona() {
        let num = $('#id').val();
        alert(parseInt(num));
        let db = new Dexie("personas");
        db.version(1).stores({
            persona: '++id,nombre,sector, nivelAcademico, latitud, longitud, sincronizado'
        });
        db.persona.update(parseInt(num), {
            nombre: $('#nombreModificar').val(),
            sector: $('#sectorModificar').val(),
            nivelAcademico: $('#nivelEscolarModificar').val()
        }).then(function (updated) {
            if (updated) {
                mostrarTabla();
                $('#modalEditar').modal('hide');
            } else
                console.log("Nothing was updated - there were no friend with primary key: 2");
        });
    }

</script>
</body>
</html>
