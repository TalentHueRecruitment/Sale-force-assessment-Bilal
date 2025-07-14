public class Cow extends Animal {
    public override void makeNoise() {
        moo();
    }

    public override void move() {
        walk();
    }

    // Does not override swim; uses default (cannot swim)
}
