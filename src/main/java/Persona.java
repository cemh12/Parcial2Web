import javax.annotation.Generated;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Persona {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int ID;
    private String Nombre;
    private String Sector;
    private String NivelAcademico;
    private String Latitud;
    private String Longitud;

    public Persona(String nombre, String sector, String nivelAcademico, String latitud, String longitud) {
        Nombre = nombre;
        Sector = sector;
        NivelAcademico = nivelAcademico;
        Latitud = latitud;
        Longitud = longitud;
    }
    public Persona() {

    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public String getSector() {
        return Sector;
    }

    public void setSector(String sector) {
        Sector = sector;
    }

    public String getNivelAcademico() {
        return NivelAcademico;
    }

    public void setNivelAcademico(String nivelAcademico) {
        NivelAcademico = nivelAcademico;
    }

    public String getLatitud() {
        return Latitud;
    }

    public void setLatitud(String latitud) {
        Latitud = latitud;
    }

    public String getLongitud() {
        return Longitud;
    }

    public void setLongitud(String longitud) {
        Longitud = longitud;
    }
}
