package web.gvarni.servletfinal;
import java.io.Serializable;

public class City implements Serializable {
    private String name;
    private String region;
    private float area;
    private int population;

    public City() {}

    public String getName() {
        return name;
    }

    public String getRegion() {
        return region;
    }

    public double getArea() {
        return area;
    }

    public int getPopulation() {
        return population;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public void setArea(float area) {
        this.area = area;
    }

    public void setPopulation(int population) {
        this.population = population;
    }
}
