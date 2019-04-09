import com.google.gson.JsonArray;
import freemarker.template.Configuration;
import servicios.JsonTransformer;
import spark.ModelAndView;
import spark.template.freemarker.FreeMarkerEngine;
import servicios.CRUD;
import servicios.ServiciosBootStrap;

import java.util.HashMap;
import java.util.Map;

import static spark.Spark.*;

public class Main {

    public static void main(String[] args) {

        ServiciosBootStrap.getInstancia().init();

        Configuration configuration = new Configuration(Configuration.getVersion());
        configuration.setClassForTemplateLoading(Main.class, "/templates");
         //staticFiles.location("/publico");
        staticFiles.location("/public");
        FreeMarkerEngine freeMarkerEngine = new FreeMarkerEngine(configuration);



        new CRUD<Persona>().save(new Persona("Joshua la perra", "Monte la zanja", "Bachiller", "klk", "Klk"));

        get("/", (request, response) -> {
            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "Create.ftl");
        }, freeMarkerEngine);

        post("/Crear/", (request, response) -> {
            Map<String, Object> attributes = new HashMap<>();
            new CRUD<Persona>().save(new Persona(request.queryParams("Nombre"),
                    request.queryParams("Sector"), request.queryParams("NivelAcademico"),
                    request.queryParams("Latitud"), request.queryParams("Longitud")));

            return new ModelAndView(attributes, "create.ftl");
        }, freeMarkerEngine);

        post("/sincronizar", (request, response) -> {
            String personasJSON = request.body();
            JsonArray personas = JsonTransformer.stringToJsonArray(personasJSON);
//            System.out.printf("Personas JSON: %s" , personas.get(0).getAsJsonObject().get("nombre"));

            for (int i=0; i < personas.size(); i++){
                //System.out.println("Nombre: " + encuesta.get("nombre").getAsString() + " Sector: "+ encuesta.get("sector").getAsString() + "Nivel: " + encuesta.get("nivel").getAsString() + " Longitud: " + encuesta.get("longitud").getAsString() + "Latitud: " + encuesta.get("latitud").getAsString());
                new CRUD<Persona>().save(new Persona(personas.get(i).getAsJsonObject().get("nombre").getAsString(),
                        personas.get(i).getAsJsonObject().get("sector").getAsString(),
                        personas.get(i).getAsJsonObject().get("nivelAcademico").getAsString(),
                        personas.get(i).getAsJsonObject().get("latitud").getAsString(),
                        personas.get(i).getAsJsonObject().get("longitud").getAsString()));
            }
            return "Aceptado";
        });
    }
}
