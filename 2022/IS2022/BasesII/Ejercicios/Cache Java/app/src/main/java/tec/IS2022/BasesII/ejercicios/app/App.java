package tec.IS2022.BasesII.ejercicios.app;
import tec.IS2022.BasesII.ejercicios.domain.LRUCache;
import java.util.Random;

public class App {


    public static void insert_data(LRUCache cache, int capacity){
        int random_value;
        for (int i = 0; i < capacity; i++){
            random_value =  new Random().nextInt(25);
            cache.put(i, random_value);
            //cache.print_list();
        }
    }

    public static void insert_with_fulled_cache(LRUCache cache){
        int capacity = cache.getCache_capacity() + 1;
        cache.put(capacity, 256);
        System.out.print(" ~$ Se inserta '256'\n");
        cache.print_list();
    }


    public static void get_LRU_Object(LRUCache cache) {
        System.out.print(" ~$ Se obtiene el elemento más antiguo de la caché.\n");
        cache.get(1);
    }


    public static void main(String[] args) {
        int capacidad = 15;
        LRUCache cache = new LRUCache(capacidad);

        insert_data(cache, capacidad);
        cache.print_list();

        insert_with_fulled_cache(cache);
        cache.print_list();

        get_LRU_Object(cache);
        cache.print_list();
    }
}
