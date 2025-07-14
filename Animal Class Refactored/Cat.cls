public class Cat extends Animal {
    public override void makeNoise() {
        meow();
    }

    public override void move() {
        walk();
    }

    // No swim override; uses default
}
