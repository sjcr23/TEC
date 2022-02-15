package tec.IS2022.BasesII.ejercicios.domain;
import java.util.HashMap;
import java.util.Map;

public class LRUCache{

    final Node head = new Node();
    final Node tail = new Node();
    Map<Integer, Node> node_map;
    int cache_capacity;

    public LRUCache(int capacity) {
        node_map = new HashMap<>(capacity);
        this.cache_capacity = capacity;
        head.next = tail;
        tail.prev = head;
    }

    public int get(int key){
        int result = -1;
        Node node = node_map.get(key);
        if (node != null){
            result = node.val;
            remove(node);
            add(node);
        }
        return result;
    }

    public int getCache_capacity() {
        return cache_capacity;
    }

    // Put method will override a node.
    public void put(int key, int value){
        Node node = node_map.get(key);
        if (node != null){
            remove(node);
            node.val = value;
            add(node);
        }
        else{
            if(node_map.size() == cache_capacity){
                node_map.remove(tail.prev.key);
                remove(tail.prev);
            }
            Node new_node = new Node();
            new_node.key = key;
            new_node.val = value;

            node_map.put(key, new_node);
            add(new_node);
        }
    }

    public void add(Node node){
        Node head_next = head.next;
        node.next = head_next;
        head_next.prev = node;
        head.next = node;
        node.prev =  head;
    }

    public void remove(Node node){
        Node next_node = node.next;
        Node prev_node = node.prev;
        // Changing the nodes.
        next_node.prev = prev_node;
        prev_node.next = next_node;
    }

    public static class Node {
        int key;
        int val;
        Node prev;
        Node next;

        public int getVal() {
            return val;
        }
    }

    public void print_list(){
        Node current = head.next;
        String r = "* -> ";
        while (current.next != null){
            Node n = current;
            Node next_node = current.next;

            if (next_node.next == null){
                r += n.getVal() + " <- *";
            }
            else {
                r +=  n.getVal() + " - " ;
            }
            current = n.next;
        }
        System.out.print("-----------------------------------------------------------------------------------------------\n");
        System.out.print("Elementos en la Caché: " + node_map.size() + "\n");
        System.out.print("Capacidad de la Caché: " + (this.getCache_capacity()-node_map.size()) + "\n");
        System.out.print("Head: " + this.head.next.getVal() + "\n");
        System.out.print("Tail: " + this.tail.prev.getVal() + "\n");
        System.out.print("Cache: " + r + "\n\n\n");
    }
}