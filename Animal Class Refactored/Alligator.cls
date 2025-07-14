public class Alligator extends Animal {
    public override void makeNoise() {
        hiss();
    }

    public override void move() {
        hiss(); // Based on original logic
    }

    public override void swim() {
        doSwim();
    }
}
