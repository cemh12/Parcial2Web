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
                <li><a href="/">Home</a></li>
                <li><a href="/Home/About">About</a></li>
                <li><a href="/Home/Contact">Contact</a></li>
            </ul>


            <ul class="nav navbar-nav navbar-right">
                <li><a href="/Identity/Account/Register">Register</a></li>
                <li><a href="/Identity/Account/Login">Login</a></li>
            </ul>

        </div>
    </div>
</nav>


<nav id="cookieConsent" class="navbar navbar-default navbar-fixed-top" role="alert">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#cookieConsent .navbar-collapse">
                <span class="sr-only">Toggle cookie consent banner</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <span class="navbar-brand"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></span>
        </div>
        <div class="collapse navbar-collapse">
            <p class="navbar-text">
                Use this space to summarize your privacy and cookie use policy.
            </p>
            <div class="navbar-right">
                <a class="btn btn-info navbar-btn" href="/Home/Privacy">Learn More</a>
                <button type="button" class="btn btn-default navbar-btn"
                        data-cookie-string=".AspNet.Consent=yes; expires=Wed, 01 Apr 2020 19:46:09 GMT; path=/; secure; samesite=lax">
                    Accept
                </button>
            </div>
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

    <h2>Create</h2>

    <h4>Persona</h4>
    <hr/>
    <div class="row">
        <div class="col-md-4">
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
                    <label class="control-label" for="Latitud">Latitud</label>
                    <input class="form-control" type="text" id="Latitud" name="Latitud" value=""/>
                    <span class="text-danger field-validation-valid" data-valmsg-for="Latitud"
                          data-valmsg-replace="true"></span>
                </div>
                <div class="form-group">
                    <label class="control-label" for="Longitud">Longitud</label>
                    <input class="form-control" type="text" id="Longitud" name="Longitud" value=""/>
                    <span class="text-danger field-validation-valid" data-valmsg-for="Longitud"
                          data-valmsg-replace="true"></span>
                </div>
                <div class="form-group">
                    <input type="submit" value="Create" class="btn btn-default"/>
                </div>
                <input name="__RequestVerificationToken" type="hidden"
                       value="CfDJ8FOIdKNfwHdLtkScnM06FRe4wlzzl9dxY39Vh4uFIbULJdjsLuGkc8x4t4arG4vyEUDlHHm0HyJqZfDyc44Up4MwuIrAFTQG5f3aYUzofPCywLh0gdym48XzfowSOePxPJpWhpR5BIYefmMFGjmLl2c"/>
            </form>
        </div>
    </div>
    <button id="sincronizar" onclick="sincronizar()">Sincronizar, pa la chercha.</button>
    <div>
        <a href="/personas">Back to List</a>
    </div>


    <hr/>
    <footer>
        <p>&copy; 2019 - parcial2web</p>
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
            enableHighAccuracy: true,
            timeout: 3000,      //30 segundos
            maximumAge: 36000   //1 hora
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
        alert("Guardado");
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
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 12,
            center: new google.maps.LatLng(2.8, -187.3),
            mapTypeId: 'terrain'
        });

        // Loop through the results array and place a marker for each
        // set of coordinates.
        let datos = [];
        buscarPersonas().then(function (results) {

            results.forEach(function (data) {
                var latLng = new google.maps.LatLng(data.latitud, data.longitud);
                var marker = new google.maps.Marker({
                    position: latLng,
                    map: map
                });
            })

        });
    }


</script>
</body>
</html>
