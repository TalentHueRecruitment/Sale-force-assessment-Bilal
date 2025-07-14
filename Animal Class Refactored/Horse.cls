public class Horse extends Animal {
    public override void makeNoise() {
        neigh();
    }

    public override void move() {
        slide();
    }

    // Does not override swim; uses default (cannot swim)
}
